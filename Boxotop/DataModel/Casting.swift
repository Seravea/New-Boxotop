//
//  Casting.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation


struct CastingResponse: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    let order: Int
    
    
    enum CodinkKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
        case order
        
    }
}

struct ImagesResponse: Codable {
    let id: Int
    let profiles: [PersonImageURL]
}


struct PersonImageURL: Codable {
    let filePath: String?
    
    var imageURL: URL? {
        if let path = filePath {
            let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")!
            return baseURL.appending(path: path)
        }else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
