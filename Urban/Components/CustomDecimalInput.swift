//
//  CustomDecimalInput.swift
//  Urban
//
//  Created by Juliana Estrela on 23/09/2023.
//

import SwiftUI

struct CustomDecimalInput: View {
    @Binding var value: Decimal?
    let placeholder: LocalizedStringKey

    var body: some View {
        TextField(
            "aaa",
            value: $value,
            format: .currency(code: "EUR"),
            prompt: Text(placeholder)
                .foregroundColor(ColorPalette.highlightsPlus)
        )
        .keyboardType(.decimalPad)
        .foregroundColor(ColorPalette.secondary)
    }
}

struct CustomDecimalInput_Previews: PreviewProvider {
    static var previews: some View {
        let inputValue = Binding<Decimal?>(
            get: { 12323 },
            set: { _ in }
        )

        CustomDecimalInput(value: inputValue, placeholder: "Placeholder")
            .padding()
            .background(ColorPalette.primary)
    }
}
