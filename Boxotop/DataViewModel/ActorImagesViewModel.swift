//
//  ActorImagesViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


@MainActor class ActorImagesViewModel: ObservableObject {
    @Published private(set) var actorURLsImage: [PersonImageURL] = []
    
    
    func loadActorURLsImage(actorID: Int) async {
        let base: LoadingProperties = .actorImages(actorID: actorID)
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
            let decodedData = try decoder.decode(ImagesResponse.self, from: data)
            
            self.actorURLsImage = decodedData.profiles
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
    }
}
