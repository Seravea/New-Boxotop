//
//  BaseUIRessources.swift
//  Boxotop
//
//  Created by Romain Poyard on 20/06/2023.
//

import Foundation
import SwiftUI





extension Color {
    static let myGrey: Color = Color("myGrey")
    
    static let myGreen: Color = Color("myGreen")
    
    static let myBckgDetailsView: Color = Color("bckgDetailsView")
}



func shadowColorOnColorScheme(colorSchemeToCheck: ColorScheme) -> Color {
    
    
    if colorSchemeToCheck == .dark {
        return .white
    }else {
        return .black
    }
    
}

func myDateFormatter(dateString: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
    let date: Date = dateFormatter.date(from: dateString) ?? Date.now
    
    return date.formatted(.dateTime.day().month().year())
    
}

extension View {
    
    func myShapeButtonOverlayStyle(color: Color) -> some View {
        self
            .overlay(content: {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(
                        LinearGradient(colors: [color.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom)
                    )
            })
    }
}


