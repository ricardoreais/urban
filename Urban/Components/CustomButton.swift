//
//  CustomButton.swift
//  Urban
//
//  Created by Juliana Estrela on 02/08/2023.
//

import SwiftUI

struct CustomButton: View {
    let label: LocalizedStringKey
    let action: () -> Void

    var body: some View {
        Button(label, action: action)
            .foregroundColor(.accentColor)
            .listRowBackground(Color.clear)
            .padding(.horizontal, 0.0)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(label: "signUp", action: {
            // Add signUp() action here
            // For preview purposes, you can add print statement
            print("Sign Up button tapped")
        })
        .background(ColorPalette.primary) // Optional: Add background color for better preview
    }
}
