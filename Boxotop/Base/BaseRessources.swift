//
//  BaseRessources.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation

//en-US



func checkAndReturnLocaleIdentifierForURL(localeToCheck: String) -> String {
    if localeToCheck == "fr" {
        return "fr-FR"
    }else if localeToCheck == "en" {
        return "en-US"
    }else {
        return "en-US"
    }
}


enum LoadingProperties {
    case boxOfficeMovies(language: String)
    case similarMovies(movieID: Int, language: String)
    case actorsList(movieID: Int, language: String)
    case actorImages(actorID: Int)
    case movieTrailers(movieID: Int, language: String)
    case defaultRessources
    
    
    
    var apiKey: String {
        "eed456115041deb5c36ed519eafea41a"
        
    }
    var headers: [String : String] {
        [
            "accept": "application/json",
            "Authorization": "Bearer eed456115041deb5c36ed519eafea41a"
        ]
    }
    
    var ApiURL: URL? {
        switch self {
        case .boxOfficeMovies(let language):
            return URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=\(checkAndReturnLocaleIdentifierForURL(localeToCheck: language))&page=1")!
        case .similarMovies(let movieID, let language):
            return URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=\(apiKey)&language=\(checkAndReturnLocaleIdentifierForURL(localeToCheck: language))&page=1")!
        case .actorsList(let movieID, let language):
            return URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(apiKey)&language=\(checkAndReturnLocaleIdentifierForURL(localeToCheck: language))")!
        case .actorImages(let actorID):
            return URL(string: "https://api.themoviedb.org/3/person/\(actorID)/images?api_key=\(apiKey)")!
        case .movieTrailers(let movieID, let language):
            return URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=\(checkAndReturnLocaleIdentifierForURL(localeToCheck: language))")
        case.defaultRessources:
            return nil
        }
    }
    
    var myURLRequest: URLRequest {
        var returnURLRequest = URLRequest(url: self.ApiURL!)
        returnURLRequest.httpMethod = "GET"
        returnURLRequest.allHTTPHeaderFields = headers
        return returnURLRequest
    }
    
    
}

func findIndex(movies: [Movie], movieToCheck: Movie) -> Int {
    var foundIndex: Int = -1
    for (index , movie) in movies.enumerated() {
        if movieToCheck.id == movie.id {
            foundIndex = index
        }
        
    }
    return foundIndex
    
}



enum PickerSelection: String, CaseIterable {
    case synopsis = "Synopsis"
    case casting = "Casting"
    case similar = "Similar"
    
    func localizedString() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
}
