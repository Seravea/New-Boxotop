//
//  MyYouTubeNavigation.swift
//  Boxotop
//
//  Created by Romain Poyard on 23/06/2023.
//

import SwiftUI
import WebKit


struct MyYouTubeNavigation: View {
    let movieKey: String
    var body: some View {
        VStack(alignment: .leading) {
            
            YouTubeView(youtubeVideoKey: movieKey)
                .frame(height: 220)
        }
        
    }
}

struct MyYouTubeNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MyYouTubeNavigation(movieKey: "03450325")
    }
}
