//
//  ActorCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct ActorCellView: View {
    @Environment (\.colorScheme) var colorScheme
    
    let person: Cast
    @StateObject var actorImageViewModel = ActorImagesViewModel()
    var body: some View {
        VStack {
            if actorImageViewModel.actorURLsImage.isEmpty == false {
                VStack {
                    if let imageURL = actorImageViewModel.actorURLsImage[0].imageURL {
                        AsyncImage(url: imageURL) { image in
                            
                            VStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 160)
                                    .clipped()
                                    .cornerRadius(9)
                                    .shadow(color: .white, radius: 0.4)
                                Text(person.name)
                                    .font(.caption)
                            }
                            .padding(.horizontal)
                            
                        } placeholder: {
                            
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 9)
                                        .frame(width: 100, height: 160)
                                        .foregroundColor(.gray.opacity(0.3))
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                .padding(.horizontal)
                                Text(" ")
                                    .font(.footnote)
                            }                        }
                        
                    }else {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: 110, height: 160)
                    }
                }
                
            }
        }
        .task {
            await actorImageViewModel.loadActorURLsImage(actorID: person.id)
        }
        
    }
}

struct ActorCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActorCellView(person: previewCastingResponse.cast[2])
    }
}
