//
//  CustomCalendar.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date

    var minimumSelectableDate: Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return today
    }

    var maximumSelectableDate: Date {
        let calendar = Calendar.current
        let twoMonthsFromNow = calendar.date(byAdding: .month, value: 2, to: Date())!
        return twoMonthsFromNow
    }

    var body: some View {
        DatePicker(
            "",
            selection: $selectedDate,
            in: minimumSelectableDate ... maximumSelectableDate,
            displayedComponents: [.date, .hourAndMinute]
        ).onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .onDisappear {
            UIDatePicker.appearance().minuteInterval = 1
        }
        .colorScheme(.dark)
        .datePickerStyle(.graphical)
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        let inputValue = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        return CustomBackground {
            CustomForm {
                CustomSection {
                    CustomDatePicker(selectedDate: inputValue)
                }
            }
        }
    }
}
