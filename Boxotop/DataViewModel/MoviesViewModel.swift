//
//  MoviesViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation

@MainActor class MovieViewModel: ObservableObject {
    @Published private(set) var boxOfficeMovies: [Movie] = []
   
    
    
    
    func loadBoxOfficeMovies(language : String) async {
        let base: LoadingProperties = .boxOfficeMovies(language: language)
        
        do {
            guard base.ApiURL != nil else {
                print("Couldn't load URL")
                return
            }
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error when fetching data on the URLSession \(networkResponse)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(MoviesResponse.self, from: data)
            
            self.boxOfficeMovies = decodedData.results
            print("movies is ok !!")
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
        
    }
    
    
}
