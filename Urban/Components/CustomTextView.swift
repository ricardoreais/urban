//
//  CustomTextView.swift
//  Urban
//
//  Created by Juliana Estrela on 25/06/2023.
//

import SwiftUI

struct CustomTextView: View {
    let label: String
    let value: String
    
    var body: some View {
        Text(label)
            .foregroundColor(.accentColor)
            .fontWeight(.bold) +
        Text(value)
    }
    
    static func +(lhs: CustomTextView, rhs: CustomTextView) -> some View {
        return HStack {
            lhs
            rhs
        }
    }
}

struct CustomTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextView(label: "Cliente ", value: "Ricardo Reais")
    }
}
