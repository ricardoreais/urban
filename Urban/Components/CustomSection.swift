//
//  CustomSection.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import SwiftUI

struct CustomSection<Content: View>: View {
    let header: String?
    let content: Content
    
    init(header: String? = nil, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }
    
    var body: some View {
        Section(header: Text(LocalizedStringKey(header ?? ""))) {
            content
                .foregroundColor(ColorPalette.secondary)
        }
        .foregroundColor(.accentColor)
        .listRowBackground(ColorPalette.highlights)
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
                Text("Wow")
                NavigationLink(destination: Text("siu")) {
                    HStack {
                        Text("Meow2")
                        Spacer()
                        Text("A,B, C")
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(ColorPalette.primary)
    }
}
