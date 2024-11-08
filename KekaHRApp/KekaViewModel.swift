//
//  KekaViewModel.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import UIKit

class KekaViewModel {
    var information : [APIModel] = []
    weak var delegate: APIDelegates?
    func loadInformation(completion: @escaping () -> Void) {
        APIManager.shared.fetchData(modelType: ApiResponse.self) { [weak self] result in
            switch result {
            case .success(let details):
                self?.information = details.response.docs
                self?.delegate?.getAPIResponse()
//                details.response.docs.forEach {
//                    CoreDataManager().saveDetailsUsingCoreData($0)
//                }
            case .failure:
                break
//                CoreDataManager().fetchDetailsFromCoreData { details in
//                    self?.information = details
//                }
            }
        }
    }
}
