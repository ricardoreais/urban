//
//  CustomPicker.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import SwiftUI

struct EvaluationPicker: View {
    public var selection: Binding<Evaluation>
    public var label: LocalizedStringKey
    
    var body: some View {
        CustomPicker(selection: selection, label: label, options: [Evaluation.bad, Evaluation.medium, Evaluation.good, Evaluation.veryGood])
    }
}

struct EvaluationPicker_Previews: PreviewProvider {
    static var previews: some View {
        let selection = Binding<Evaluation>(
            get: { Evaluation.good },
            set: { _ in }
        )
        EvaluationPicker(selection: selection, label: "location")
            .padding()
            .background(ColorPalette.primary)
    }
}
