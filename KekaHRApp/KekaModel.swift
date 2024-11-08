//
//  KekaModel.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import Foundation

struct ApiResponse: Decodable {
    let response: Response
}
struct Response: Decodable {
    let docs: [APIModel]
}

 struct APIModel: Decodable {
     let abstract: String
     let multimedia: [Multimedia]
     let headline: Headline
     let pubDate: String
    
     private enum CodingKeys: String, CodingKey {
         case abstract
         case multimedia
         case headline
         case pubDate = "pub_date"
     }
}

struct Headline: Decodable {
    let main: String
}
struct Multimedia: Decodable {
    let url: String
}
