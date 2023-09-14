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
    @Published var errorMessage: String?
    @Published var isErrorAlertPresented: Bool = false
    
    
    private func loadMovieCasting(movieID: Int, language: String) async {
        
        let base: LoadingProperties = .actorsList(movieID: movieID, language: language)
        
        do {
            guard base.apiURL != nil else {
                errorMessage = ErrorHandling.urlNil.message
                isErrorAlertPresented = true
                return
            }
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                errorMessage = ErrorHandling.urlSessionError(urlResponse: networkResponse).message
                isErrorAlertPresented = true
                return
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CastingResponse.self, from: data)
            
            self.movieCasting = decodedData
            
        }catch {
            errorMessage = ErrorHandling.errorDatabase(errorString: error).message
            isErrorAlertPresented = true
        }
        
    }
    
    
    private func loadSimilarMovies(movieID: Int, language : String) async {
        
        let base: LoadingProperties = .similarMovies(movieID: movieID, language: language)
        
        do {
            guard base.apiURL != nil else {
                errorMessage = ErrorHandling.urlNil.message
                isErrorAlertPresented = true
                return
            }
            
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                errorMessage = ErrorHandling.urlSessionError(urlResponse: networkResponse).message
                isErrorAlertPresented = true
                return
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(MoviesResponse.self, from: data)
            
            self.similarMovies = decodedData.results
            
        }catch {
            errorMessage = ErrorHandling.errorDatabase(errorString: error).message
            isErrorAlertPresented = true
        }
        
        
    }
    
    private func loadTrailerVideoFile(movieID: Int, language: String) async {
        let base: LoadingProperties = .movieTrailers(movieID: movieID, language: language)
        
        do {
            guard base.apiURL != nil else {
                errorMessage = ErrorHandling.urlNil.message
                isErrorAlertPresented = true
                return
            }
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                errorMessage = ErrorHandling.urlSessionError(urlResponse: networkResponse).message
                isErrorAlertPresented = true
                return
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(TrailerResponseBody.self, from: data)
            
            
            self.trailers = decodedData.results
            
        }catch {
            errorMessage = ErrorHandling.errorDatabase(errorString: error).message
            isErrorAlertPresented = true
        }
        
    }
    
    
    func fetchingDataDetailsView(movieID: Int, language: String) async {
        Task {
            await loadMovieCasting(movieID: movieID, language: language)
            await loadSimilarMovies(movieID: movieID, language: language)
            await loadTrailerVideoFile(movieID: movieID, language: language)
            
        }
    }
    
    
}
