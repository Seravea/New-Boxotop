//
//  SimilarMovieCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct SimilarMovieCellView: View {
    @Environment (\.colorScheme) var colorScheme
    
    let movie: Movie
    var body: some View {
        AsyncImage(url: movie.posterURL, transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
            case .success(let image):
                ZStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 160)
                        .clipped()
                        .cornerRadius(9)
                        .shadow(color: shadowColorOnColorScheme(colorSchemeToCheck: colorScheme), radius: 1)
                }
            case .failure:
                Rectangle()
                    .frame(width: 110, height: 160)
                    .clipped()
                    .cornerRadius(9)
                    .shadow(color: shadowColorOnColorScheme(colorSchemeToCheck: colorScheme), radius: 1)
            default:
                Text("no error but case default")
            }
        }
    }
}


struct SimilarMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieCellView(movie: previewResponseData.results[0])
    }
}
