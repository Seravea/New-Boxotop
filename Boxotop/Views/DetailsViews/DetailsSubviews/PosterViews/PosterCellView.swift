//
//  PosterCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 20/06/2023.
//

import SwiftUI

struct PosterCellView: View {
    @Environment(\.colorScheme) var colorScheme
    let movie: Movie
    @Binding var isZoomOn: Bool
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: isZoomOn ? 300 : 150, height: isZoomOn ? 400 : 200)
                    .transition(.scale)
                    .clipped()
                    .cornerRadius(9)
                    .shadow(color: shadowColorOnColorScheme(colorSchemeToCheck: colorScheme) , radius: 0.5)
                
            } placeholder: {
                
                Rectangle()
                    .frame(width: 150, height: 200)
                    .cornerRadius(9)
                    .foregroundColor(.gray.opacity(0.9))
                    .padding(.trailing, 8)
                    .shadow(radius: 0.1)
                
            }
            
            Button {
                withAnimation {
                    isZoomOn.toggle()
                }
                
            }label: {
                Image(systemName: "\(isZoomOn ? "minus" : "plus").magnifyingglass")
                    .foregroundColor(.black)
                    .padding(5)
                    .background(Circle().foregroundColor(.myGreen.opacity(0.8)))
            }
            .buttonStyle(.borderless)
            .padding(2)
            
            
        }
        .animation(.spring(), value: isZoomOn)
        
    }
}

struct PosterCellView_Previews: PreviewProvider {
    static var previews: some View {
        PosterCellView(movie: previewResponseData.results[0], isZoomOn: .constant(true))
    }
}

