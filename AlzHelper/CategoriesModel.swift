//
//  CategoriesModel.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import Foundation
import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let color: Color
}

class CategoriesModel: ObservableObject {
    @Published var categories: [Category] =
    [
        Category(name: "animals", image: "🐶", color: .red),
        Category(name: "food", image: "🍽", color: .blue),
        Category(name: "clothes", image: "👕", color: .yellow),
        Category(name: "shops", image: "🏬", color: .green),
    ]
}
