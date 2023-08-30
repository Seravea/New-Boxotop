//
//  MovieDetails.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct MovieDetails: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let movie: Movie
    
    @StateObject var movieDetailsViewModel = MovieDetailsViewModel()
    
    @State var selectedSimilarMovie: Movie?
    
    @State var zoomOnPoster: Bool = false
    
    var body: some View {

        VStack(alignment: .leading) {
            
            Text(movie.title)
                .font(.largeTitle)
                .padding(.horizontal)
            
            
            List {
                
                HStack(spacing: 20) {
                    
                    PosterCellView(movie: movie, isZoomOn: $zoomOnPoster)
                    
                    if zoomOnPoster == false {
                        VStack(alignment: .leading) {
                            
                            Text("Release date:")
                            Text("\(movie.releaseDate)")
                                .padding(.bottom, 5)
                            
                            Text("Audience :")
                            StarsNotationView(vote: movie.voteAverage)
                                .padding(.bottom, 5)
                            
                            Text("Vote count:")
                            Text("\(movie.voteCount)")
                                .padding(.bottom, 5)
                            
                            Text("My rating:")
                            MyMovieRatingView(movieID: movie.id)
                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
                    
                
                
                Section("Synopsis") {
                    Text(movie.overview)
                }
                
                
                Section("Casting") {
                    if let casting = movieDetailsViewModel.movieCasting {
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(casting.cast.sorted(by: {$0.order < $1.order}).prefix(5), id: \.id) { person in
                                    
                                    ActorCellView(person: person)
                                        .padding(.vertical, 5)
                                    
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                
                Section("Similar Movies") {
                    if movieDetailsViewModel.similarMovies.isEmpty == false {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(movieDetailsViewModel.similarMovies, id: \.id) { similarMovie in
                                    Button {
                                        selectedSimilarMovie = similarMovie
                                        
                                    } label: {
                                        SimilarMovieCellView(movie: similarMovie)
                                            .padding(.horizontal)
                                            .padding(.vertical, 5)
                                    }
                                    
                                    
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                    }
                }
                .sheet(item: $selectedSimilarMovie) { movie in
                    SimilarMovieDetailsView(selectedMovie: $selectedSimilarMovie)
                        .presentationDetents([.medium, .large])
                    
                }
                
                
            }
            .listStyle(.plain)
            
            .task {
//                await movieDetailsViewModel.fetchingDataDetailsView(movieID: movie.id)
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: previewResponseData.results[14])
    }
}





