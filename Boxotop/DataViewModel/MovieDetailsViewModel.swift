//
//  MovieDetailsViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


@MainActor class MovieDetailsViewModel: ObservableObject {
    @Published private(set) var movieCasting: CastingResponse?
    @Published private(set) var similarMovies: [Movie] = []
    @Published var trailers: [TrailerFile] = []
    
    
    private func loadMovieCasting(movieID: Int, language: String) async {
        
        let base: LoadingProperties = .actorsList(movieID: movieID, language: language)
        
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
            let decodedData = try decoder.decode(CastingResponse.self, from: data)
            
            self.movieCasting = decodedData
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
    }
    
    
    private func loadSimilarMovies(movieID: Int, language : String) async {
        
        let base: LoadingProperties = .similarMovies(movieID: movieID, language: language)
        
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
            
            self.similarMovies = decodedData.results
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
        
    }
    
    private func loadTrailerVideoFile(movieID: Int, language: String) async {
        let base: LoadingProperties = .movieTrailers(movieID: movieID, language: language)
        
        do {
            guard let url = base.ApiURL else {
                print("Couldn't load URL")
                return
            }
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error when fetching data on the URLSession \(networkResponse)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(TrailerResponseBody.self, from: data)
            
            
            self.trailers = decodedData.results
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
    }
    
    
    func fetchingDataDetailsView(movieID: Int, language: String) async {
        Task {
            await loadMovieCasting(movieID: movieID, language: language)
            await loadSimilarMovies(movieID: movieID, language: language)
            await loadTrailerVideoFile(movieID: movieID, language: language)
            print("this movie is showing")
        }
    }
    
    
}
