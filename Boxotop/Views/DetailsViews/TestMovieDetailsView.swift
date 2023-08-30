//
//  TestMovieDetailsView.swift
//  Boxotop
//
//  Created by Romain Poyard on 22/06/2023.
//

import SwiftUI



struct TestMovieDetailsView: View {
    
    @Environment(\.locale.language.languageCode?.identifier) var localeIdentifier
    @State var selectedMovie: Movie? = nil
   
    
    @StateObject var movieDetailsViewModel = MovieDetailsViewModel()
    let movie: Movie
    
    @State var selectedPicker: PickerSelection = .synopsis
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                AsyncImage(url: movie.posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(minWidth: geo.size.width, minHeight: geo.size.height)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                ZStack {
                    
                    LinearGradient(colors: [.clear, .myBckgDetailsView.opacity(0.3), .myBckgDetailsView, .myBckgDetailsView], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            
                            if movieDetailsViewModel.trailers.count > 0 {
                                NavigationLink {
                                    
                                    MyYouTubeNavigation(movieKey: movieDetailsViewModel.trailers[0].key)
                                    
                                    
                                } label: {
                                    Label("Watch trailer", systemImage: "play.circle")
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.myGreen)
                                .myShapeButtonOverlayStyle(color: .white)
                                
                            }else {
                                Label("No trailer", systemImage: "play.slash")
                                    .padding(10)
                                    .padding(.horizontal, 20)
                                    .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundColor(.myGrey.opacity(0.3))
                                    )
                            }
                            
                            Text(movie.title)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            
                            HStack(spacing: 40){
                                VStack(alignment:.leading) {
                                   
                                    MyMovieRatingView(movieID: movie.id)
                                        .font(.footnote)
                                }
                                
                                VStack(alignment:.leading) {
                                    Text("Audience")
                                        .font(.footnote)
                                        .opacity(0.9)
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text("\(Int(movie.voteAverage) / 2)")
                                            .fontWeight(.semibold)
                                        
                                    }
                                    .font(.footnote)
                                    
                                    
                                }
                                .foregroundColor(.white)
                                
                                VStack(alignment:.leading) {
                                    Text("Release date")
                                        .font(.footnote)
                                        .opacity(0.9)
                                    
                                    
                                    Text(myDateFormatter(dateString: movie.releaseDate))
                                        .fontWeight(.semibold)
                                        .font(.footnote)
                                }
                                
                                
                            }
                            
                            HStack {
                                ForEach(PickerSelection.allCases, id: \.self) { selectionTitle in
                                    Spacer()
                                    MyButtonPickerSelection(selectedPicker: $selectedPicker, selectionTitle: selectionTitle)
                                    Spacer()
                                    
                                }
                            }
                            .padding(.top)
                            VStack {
                                switch selectedPicker {
                                case .synopsis:
                                   
                                        Text(movie.overview)
                                            .padding(.top)
                                    
                                        
                                case .casting:
                                    if let cast = movieDetailsViewModel.movieCasting?.cast.prefix(5) {
                                        
                                        ScrollView(.horizontal) {
                                            HStack {
                                                ForEach(cast, id: \.id) { person in
                                                    ActorCellView(person: person)
                                                    
                                                    
                                                }
                                            }
                                        }
                                        .scrollIndicators(.hidden)
                                    }
                                case .similar:
                                    
                                    ScrollView(.horizontal) {
                                        LazyHStack {
                                            ForEach(movieDetailsViewModel.similarMovies) { similarMovie in
                                                Button {
                                                    selectedMovie = similarMovie
                                                }label: {
                                                    MyNewSimilarMovieCellView(similarMovie: similarMovie)
                                                        .padding()
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        .frame(height: geo.size.height / 3)
                                        .sheet(item: $selectedMovie) { movie in
                                            SimilarMovieDetailsView(selectedMovie: $selectedMovie)
                                                .fontDesign(.rounded)
                                                .presentationDetents([.medium, .large])
                                        }
                                    }
                                    .scrollIndicators(.hidden)
                                    
                                }
                                
                            }
                            .frame(minHeight: geo.size.height / 3)
                            
                        }
                        .padding(.horizontal)
                        .frame(minHeight: geo.size.height)
                        .task {
                            await movieDetailsViewModel.fetchingDataDetailsView(movieID: movie.id, language: localeIdentifier ?? "en-US")
                        }
                    }
                }
                
            }
            .foregroundColor(.white)
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TestMovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TestMovieDetailsView(movie: previewResponseData.results[2])
                
        }
    }
}



