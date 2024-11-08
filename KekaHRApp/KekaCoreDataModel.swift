//
//  KekaCoreDataModel.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 08/11/24.
//

import CoreData

@objc(CDDetails)
public class CDDetails: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var abstract: String?
    @NSManaged public var pubDate: String?
    @NSManaged public var imageURL: String?
}
