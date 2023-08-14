//
//  CustomLink.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import SwiftUI

struct CustomLink: View {
    let label: LocalizedStringKey?
    let url: String
    
    init(_ label: LocalizedStringKey? = nil, url: String) {
        self.label = label
        self.url = url
    }
    
    var body: some View {
        Link(label ?? "\(url)", destination: URL(string: url)!)
            .foregroundColor(ColorPalette.secondary)
    }
}

struct CustomLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomLink("Sample link", url: "https://www.kwportugal.pt/1208-4087")
            .padding()
            .background(ColorPalette.primary)
    }
}
