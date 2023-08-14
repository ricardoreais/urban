//
//  CustomButton.swift
//  Urban
//
//  Created by Juliana Estrela on 02/08/2023.
//

import SwiftUI

struct CustomButton: View {
    let label: LocalizedStringKey
    let syncAction: (() -> Void)?
    let asyncAction: (() async -> Void)?
    
    init(_ label: LocalizedStringKey, syncAction: @escaping () -> Void) {
        self.label = label
        self.syncAction = syncAction
        self.asyncAction = nil
    }
    
    init(_ label: LocalizedStringKey, asyncAction: @escaping () async -> Void) {
        self.label = label
        self.syncAction = nil
        self.asyncAction = asyncAction
    }
    
    var body: some View {
        Button(label, action: {
            if Task.isCancelled {
                // Handle cancellation if needed
            } else if let asyncAction = asyncAction {
                Task {
                    await asyncAction()
                }
            } else if let syncAction = syncAction {
                syncAction()
            }
        })
        .foregroundColor(.accentColor)
        .listRowBackground(Color.clear)
        .padding(.horizontal, 0.0)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton("signUp", syncAction: {
            // Add signUp() action here
            // For preview purposes, you can add print statement
            print("Sign Up button tapped")
        })
        .background(ColorPalette.primary) // Optional: Add background color for better preview
    }
}
