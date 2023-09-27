//
//  CustomSelectList.swift
//  Urban
//
//  Created by Juliana Estrela on 01/08/2023.
//

import SwiftUI

struct IdentifiableString: Identifiable, Hashable {
    let string: String
    var id: String { string }
}

struct CustomSelectList<Selectable: Identifiable & Hashable>: View {
    let label: String
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    var selected: Binding<Set<Selectable>>

    private var formattedSelectedListString: String {
        ListFormatter.localizedString(byJoining: selected.wrappedValue.map { optionToString($0) })
    }

    var body: some View {
        NavigationLink(destination: multiSelectionView()) {
            HStack {
                Text(LocalizedStringKey(label))
                Spacer()
                Text(formattedSelectedListString)
                    .multilineTextAlignment(.trailing)
            }
        }
        .foregroundColor(ColorPalette.secondary)
        .listRowBackground(ColorPalette.highlights)
    }

    private func multiSelectionView() -> some View {
        CustomSelectListDetail(
            options: options,
            optionToString: optionToString,
            selected: selected
        )
    }
}

struct CustomSelectList_Previews: PreviewProvider {
    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })

    static var previews: some View {
        NavigationView {
            CustomBackground {
                CustomForm {
                    CustomSelectList<IdentifiableString>(
                        label: "Multiselect",
                        options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                        optionToString: { $0.string },
                        selected: $selected
                    )
                }
            }
        }
    }
}
