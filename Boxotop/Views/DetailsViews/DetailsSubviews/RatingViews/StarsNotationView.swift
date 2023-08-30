//
//  StarsNotationView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct StarsNotationView: View {
    
    let vote: Double
    var starVote: Int {
        return Int(vote) / 2
    }
    
    var body: some View {
        
        HStack {
            ForEach(0..<starVote, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            if vote / 2 < 5 {
                ForEach(0..<(5 - starVote), id: \.self) { _ in
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
            }
            
        }
    }
}

struct StarsNotationView_Previews: PreviewProvider {
    static var previews: some View {
        StarsNotationView(vote: 9)
    }
}
