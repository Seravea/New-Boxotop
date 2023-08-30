//
//  MyMovieRatingView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct MyMovieRatingView: View {
    
    @State var myRating = 0
    
    let movieID: Int
    
    var defaults = UserDefaults.standard
    
    @State var isEditing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if defaults.integer(forKey: String(movieID)) == 0 || isEditing {
                    Text("My rating")
                }else {
                    Button {
                        withAnimation {
                            defaults.set(0, forKey: String(movieID))
                            isEditing.toggle()
                        }
                        
                    } label: {
                        Text("My rating")
                        Image(systemName: "arrow.counterclockwise")
                            .font(.callout)
                    }
                }
            }
            .font(.footnote)
            .opacity(0.9)
            HStack {
                if defaults.integer(forKey: String(movieID)) == 0 || isEditing {
                    ForEach(1...5, id: \.self) { number in
                        Image(systemName: myRating > number ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                withAnimation {
                                    myRating = number + 1
                                }
                            }
                    }
                    .onDisappear {
                        defaults.set(myRating == 0 ? 0 : myRating - 1, forKey: String(movieID))
                    }
                    
                } else {
                    HStack {
                        
                        ForEach(0...defaults.integer(forKey: String(movieID)) - 1, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        
                        
                        if defaults.integer(forKey: String(movieID)) < 5 {
                            ForEach(0..<(5 - defaults.integer(forKey: String(movieID))), id: \.self) { _ in
                                Image(systemName: "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
}

struct MyMovieRatingView_Previews: PreviewProvider {
    static var previews: some View {
        MyMovieRatingView(movieID: 1)
    }
}
