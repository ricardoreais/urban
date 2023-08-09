//
//  CustomLoading.swift
//  Urban
//
//  Created by Juliana Estrela on 09/08/2023.
//

import SwiftUI

struct CustomLoading: View {
    var body: some View {
        Logo()
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            .scaleEffect(2)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CustomLoading_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackground {
            CustomLoading()
        }
    }
}
