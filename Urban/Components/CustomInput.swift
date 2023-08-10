//
//  CustomInputView.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import SwiftUI

struct CustomInput: View {
    @Binding var text: String
    let placeholder: LocalizedStringKey

    var body: some View {
        TextField("", text: $text, prompt: {
            Text(placeholder)
                .foregroundColor(ColorPalette.highlightsPlus)
        }())
        .foregroundColor(ColorPalette.secondary)
    }
}

struct CustomInput_Previews: PreviewProvider {
    static var previews: some View {
        let inputValue = Binding<String>(
            get: { "" },
            set: { _ in }
        )
        
        CustomInput(text: inputValue, placeholder: "Placeholder")
            .padding()
            .background(ColorPalette.primary)
    }
}
