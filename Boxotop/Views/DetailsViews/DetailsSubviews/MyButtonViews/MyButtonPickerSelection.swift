//
//  MyButtonPickerSelection.swift
//  Boxotop
//
//  Created by Romain Poyard on 23/06/2023.
//

import SwiftUI

struct MyButtonPickerSelection: View {
    @Binding var selectedPicker: PickerSelection
    let selectionTitle: PickerSelection
    var body: some View {
      
        Button {
            withAnimation(.spring()) {
                selectedPicker = selectionTitle
            }
        }label: {
            Text(selectionTitle.localizedString())
                .frame(width: 69)
                .foregroundColor(selectedPicker == selectionTitle ? .black : .white)
            
        }
        .buttonStyle(.borderedProminent)
        .tint(selectedPicker == selectionTitle ? .white : .myGreen)
        .myShapeButtonOverlayStyle(color: .white)
        
        
    }
    
}

struct MyButtonPickerSelection_Previews: PreviewProvider {
    static var previews: some View {
        MyButtonPickerSelection(selectedPicker: .constant(.casting), selectionTitle: .synopsis)
        
    }
}
