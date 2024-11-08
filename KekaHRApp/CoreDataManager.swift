//
//  CoreDataManager.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func saveDetailsUsingCoreData(_ details: APIModel) {
        DispatchQueue.main.async {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let cdArticle = CDDetails(context: context)
            cdArticle.title = details.headline.main
            cdArticle.abstract = details.abstract
            cdArticle.pubDate = details.pubDate
            cdArticle.imageURL = details.multimedia.first?.url
            
            do {
                try context.save()
            } catch {
                print("Failed to save article: \(error)")
            }
        }
    }
    
    func fetchDetailsFromCoreData(completion: @escaping ([APIModel]) -> Void) {
        DispatchQueue.main.async {
        do {
            let fetchRequest = CDDetails.fetchRequest() as! NSFetchRequest<CDDetails>
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let cdDetails = try context.fetch(fetchRequest)
                cdDetails.map { cdDetail in
                    let abd = APIModel(abstract: cdDetail.abstract ?? "", multimedia: [Multimedia(url: cdDetail.imageURL ?? "")], headline: Headline(main: cdDetail.title ?? ""), pubDate: cdDetail.pubDate ?? "")
                    completion([abd])
                }
            }
            catch {
                print("Failed to fetch articles: \(error)")
                completion([])
            }
        }
    }
}
