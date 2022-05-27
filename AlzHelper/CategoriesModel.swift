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
//    let image: String
}

class CategoriesModel: ObservableObject {
    @Published var categories: [Category] =
    [
        Category(name: "Animals"),
        Category(name: "Food"),
        Category(name: "House"),
        Category(name: "Dress")
    ]
}
