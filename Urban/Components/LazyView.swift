//
//  LazyView.swift
//  Urban
//
//  Created by Juliana Estrela on 17/08/2023.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
