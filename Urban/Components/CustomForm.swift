//
//  CustomForm.swift
//  Urban
//
//  Created by Juliana Estrela on 02/08/2023.
//

import SwiftUI

struct CustomForm<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Form {
            content
        }
        .foregroundColor(ColorPalette.secondary)
        .scrollContentBackground(.hidden)
    }
}

struct CustomForm_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackground
        {
            CustomForm
            {
                CustomSection(header: "Test")
                {
                    CustomText(label: "Email", value: "fake@mail.com")
                }
            }
        }
    }
}
