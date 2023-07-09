//
//  CustomPicker.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import SwiftUI

struct CustomPicker<Selection: Hashable, Options: LocalizedEnum>: View {
    public var selection: Binding<Selection>
    public var label: LocalizedStringKey
    public var options: [Options]
    
    var body: some View {
        Picker(selection: selection, label: Text(label)) {
            ForEach(options, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .accentColor(ColorPalette.secondary)
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        let selection = Binding<Evaluation>(
            get: { Evaluation.good },
            set: { _ in }
        )
        CustomPicker(selection: selection, label: "location", options: [Evaluation.bad, Evaluation.medium, Evaluation.good, Evaluation.veryGood])
            .padding()
            .background(ColorPalette.primary)
    }
}
