//
//  CategoriesModel.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import Foundation

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

class CategoriesModel: ObservableObject {
    @Published var categories: [Category] =
    [
        Category(name: "animals", image: "Animals"),
        Category(name: "food", image: "Food"),
        Category(name: "clothes", image: "Clothes")
    ]
}
