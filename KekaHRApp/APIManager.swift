//
//  APIManager.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import Foundation

enum APIError: Error {
    case networkError
    case parsingError
}

protocol ApiManaging {
    func fetchData<T: Decodable>(modelType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

final class APIManager: ApiManaging {
    
    static let shared = APIManager()
    private let kekaUrl = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=j5GCulxBywG3lX211ZAPkAB8O381S5SM"
    
    func fetchData<T: Decodable>(modelType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: kekaUrl) else { return }
        let request = URLRequest(url: url)
        let shared = URLSession.shared
        shared.dataTask(with: request) { responseData, response, error in
            if let data = responseData {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let response: T
                        do {
                            response = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(response))
                        } catch {
                            completion(.failure(.parsingError))
                            return
                        }
                    }
                }
            } else {
                completion(.failure(.networkError))
            }
        }.resume()
    }
}
