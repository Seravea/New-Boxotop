//
//  PreviewDataModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation

var previewCastingResponse: CastingResponse = load("previewCastingData.json")

var previewResponseData: MoviesResponse  = load("previewMovieData.json")


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    //verify if the loading file is here in the bundle and store it
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in the main")
    }
    
    //verify if the data can load from the file constant and store it
    do {
        data = try Data(contentsOf: file)
    }catch {
        fatalError("Couldn't load \(filename) frome the main  \(error)")
    }
    
    
    //verify if the data can be decoded from the JSON file and return the Response
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch {
        fatalError("Couldn't parse \(filename) as \(T.self)  \(error)")
    }
}
