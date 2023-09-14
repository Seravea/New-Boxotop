//
//  MoviesViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation

@MainActor final class MovieViewModel: ObservableObject {
    @Published private(set) var boxOfficeMovies: [Movie] = []
    @Published var errorMessage: String?
    @Published var isErrorAlertPresented: Bool = false
    
    
    
    func loadBoxOfficeMovies(language : String) async {
        let base: LoadingProperties = .boxOfficeMovies(language: language)
        
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
            
            self.boxOfficeMovies = decodedData.results
            print("movies is ok !!")
        }catch {
            errorMessage = ErrorHandling.errorDatabase(errorString: error).message
            isErrorAlertPresented = true
        }
        
        
    }
    
    
}
