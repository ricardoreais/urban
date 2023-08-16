//
//  CustomTabView.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import SwiftUI

struct CustomTab<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        TabView {
            content
        }
        .onAppear{
            UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CustomTab_Previews: PreviewProvider {
    static var previews: some View {
        CustomTab {
            CustomBackground {
                Text("Meow")
                    .tabItem {
                        Label("myVisits", systemImage: "list.bullet")
                    }
            }
            CustomBackground {
                Text("Woof")
                    .tabItem {
                        Label("myVisits", systemImage: "list.bullet")
                    }
            }
        }
    }
}
