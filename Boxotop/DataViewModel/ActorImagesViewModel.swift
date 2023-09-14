//
//  ActorImagesViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


@MainActor class ActorImagesViewModel: ObservableObject {
    @Published private(set) var actorURLsImage: [PersonImageURL] = []
    @Published var errorMessage: String?
    @Published var isErrorAlertPresented: Bool = false
    
    
    func loadActorURLsImage(actorID: Int) async {
        let base: LoadingProperties = .actorImages(actorID: actorID)
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
            let decodedData = try decoder.decode(ImagesResponse.self, from: data)
            
            self.actorURLsImage = decodedData.profiles
            
        }catch {
            errorMessage = ErrorHandling.errorDatabase(errorString: error).message
            isErrorAlertPresented = true
        }
        
    }
}
