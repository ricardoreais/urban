//
//  SidebarView.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
           NavigationLink(destination: VisitReportFormView()) {
               Label("Criar nova visita", systemImage: "doc")
           }
           NavigationLink(destination: VisitsView()) {
               Label("As minhas visitas", systemImage: "folder")
           }
           // Add more menu items as needed
       }
       .listStyle(SidebarListStyle())
       .frame(minWidth: 200)
    }
}
	
struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
