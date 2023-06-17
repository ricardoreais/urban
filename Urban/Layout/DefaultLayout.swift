//
//  DefaultLayout.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import SwiftUI

struct DefaultLayout<Content: View>: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.detailOnly
    let content: Content
        
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView()
        } detail: {
            content
        }
        
    }
}

struct DefaultLayout_Previews: PreviewProvider {
    static var previews: some View {
        DefaultLayout(){Text("Sample content")}
    }
}
