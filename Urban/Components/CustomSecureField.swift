//
//  CustomSecureField.swift
//  Urban
//
//  Created by Juliana Estrela on 09/08/2023.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: LocalizedStringKey

    var body: some View {
        SecureField("", text: $text,
                  prompt: Text(placeholder).foregroundColor(ColorPalette.highlightsPlus))
        .disableAutocorrection(true)
        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        .foregroundColor(ColorPalette.secondary)
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        let inputValue = Binding<String>(
            get: { "Default Value" },
            set: { _ in }
        )
        
        CustomSecureField(text: inputValue, placeholder: "location")
            .padding()
            .background(ColorPalette.primary)
    }
}
