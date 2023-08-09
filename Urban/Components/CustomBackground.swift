//
//  CustomBackground.swift
//  Urban
//
//  Created by Juliana Estrela on 02/08/2023.
//

import SwiftUI

struct CustomBackground<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .foregroundColor(ColorPalette.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorPalette.primary)
        .scrollContentBackground(.hidden)
    }
}

struct CustomBackground_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackground {
            Text("Sample")
        }
    }
}
