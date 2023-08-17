//
//  CustomTextView.swift
//  Urban
//
//  Created by Juliana Estrela on 25/06/2023.
//

import SwiftUI

struct CustomText: View {
    let label: String
    let value: String?
    
    var body: some View {
        Group {
            Text(LocalizedStringKey(label))
                .foregroundColor(.accentColor)
                .fontWeight(.bold) +
            Text(" ") +
            Text(LocalizedStringKey(value ?? ""))
                .foregroundColor(ColorPalette.secondary)
        }
    }
    
    static func +(lhs: CustomText, rhs: CustomText) -> some View {
        return HStack {
            lhs
            rhs
        }
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(label: "clientName", value: "Ricardo Reais")
            .padding()
            .background(ColorPalette.primary)
    }
}
