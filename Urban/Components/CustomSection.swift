//
//  CustomSection.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import SwiftUI

struct CustomSection<Content: View>: View {
    let header: String
    let content: Content
    
    init(header: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }
    
    var body: some View {
        Section(header: Text(LocalizedStringKey(header))) {
            content
        }
        .foregroundColor(.accentColor)
        .listRowBackground(Color.clear)
    }
}

struct CustomSection_Previews: PreviewProvider {
    static var previews: some View {
        let inputValue = Binding<String>(
            get: { "Default Value" },
            set: { _ in }
        )
        Form {
            CustomSection(header: "client") {
                CustomInput(text:inputValue, placeholder: "clientName")
            }
        }
        .scrollContentBackground(.hidden)
        .background(ColorPalette.primary)
    }
}
