//
//  VisitsCalendarView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import SwiftUI

struct VisitsCalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        CustomBackground {
            CustomDatePicker(selectedDate: $selectedDate)
                .padding(.horizontal, 30)
        }
    }
}

struct VisitsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsCalendarView()
    }
}
