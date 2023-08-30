//
//  BoxOfficeListView.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct BoxOfficeListView: View {
    @Environment(\.locale.language.languageCode?.identifier) var localeIdentifier
    @State var mySearchText: String = ""
    @StateObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack {
            if movieViewModel.boxOfficeMovies.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
                    .task {
                        await movieViewModel.loadBoxOfficeMovies(language: localeIdentifier ?? "fr")
                    }
            }else {
                VStack {
                    
                    ScrollView {
                        ForEach(movieViewModel.boxOfficeMovies.filter({
                            
                            mySearchText.isEmpty ? true :
                            $0.title.localizedCaseInsensitiveContains(mySearchText.lowercased())
                            
                            
                        }), id: \.id) { movie in
                            NavigationLink {
                                TestMovieDetailsView(movie: movie)
                            }label: {
                                MovieCardView(movie: movie, index: findIndex(movies: movieViewModel.boxOfficeMovies, movieToCheck: movie))
                            }
                            .tint(.black)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    .scrollIndicators(.hidden)
                    
                }
                .navigationTitle("Box office")
                .searchable(text: $mySearchText)
                .toolbar {
                    Button{
                        Task {
                            await movieViewModel.loadBoxOfficeMovies(language: localeIdentifier ?? "fr")
                        }
                    }label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                }
            }
            
        }
        .tint(.white)
        .foregroundColor(.white)
        .fontDesign(.rounded)
        .environment(\.colorScheme, .dark)
        
    }
}

struct BoxOfficeListView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeListView()
            .environment(\.locale, .init(identifier: "fr"))
    }
}
