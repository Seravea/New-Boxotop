//
//  MovieCardView.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    let index: Int
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6)
                .frame(height: 150)
                .foregroundColor(index % 2 == 0 ? .myGreen : .myGrey)
            
            HStack(alignment: .top) {
                
                AsyncImage(url: movie.posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 130)
                        .clipped()
                        .cornerRadius(9)
                        .shadow(color: .white ,radius: 0.1)
                } placeholder: {
                    
                    ZStack {
                      
                        Rectangle()
                            .frame(width: 90, height: 130)
                            .cornerRadius(9)
                            .foregroundColor(.gray.opacity(0.9))
                            .padding(.trailing, 8)
                            .shadow(color: .white ,radius: 0.1)
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                
                VStack {
                    Text(movie.title)
                        .font(movie.title.count < 50 ? .title : .title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(index % 2 == 0 ? .white : .black)
                    
                    
                }
                
            }
            .padding(.horizontal)
        }
        .myShapeButtonOverlayStyle(color: .white)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: previewResponseData.results[19], index: 1)
    }
}
