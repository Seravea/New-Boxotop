//
//  MyNewSimilarMovieCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 23/06/2023.
//

import SwiftUI

struct MyNewSimilarMovieCellView: View {
    let similarMovie: Movie
    
    var body: some View {
        AsyncImage(url: similarMovie.posterURL) { image in
            VStack {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 160)
                    .clipped()
                    .cornerRadius(9)
                    .shadow(color: .white, radius: 0.4)
                Text(similarMovie.title.prefix(15))
                    .font(.caption)
            }
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
            }
        }
    }
}

struct MyNewSimilarMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MyNewSimilarMovieCellView(similarMovie: previewResponseData.results[0])
    }
}
