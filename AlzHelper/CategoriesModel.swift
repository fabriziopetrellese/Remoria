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

struct Items: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

class CategoriesModel: ObservableObject {
    @Published var categories: [Category] =
    [
        Category(name: "animals", image: "🐶", color: .red),
        Category(name: "food", image: "🍽", color: .blue),
        Category(name: "clothes", image: "👕", color: .yellow),
        Category(name: "shops", image: "🏬", color: .green),
    ]
    
    @Published var empty: [Items] =
    [
        Items(name: "", image: "")
    ]
    
    @Published var animals: [Items] =
    [
        Items(name: "dog", image: "Dog")
    ]
    
    @Published var food: [Items] =
    [
        Items(name: "", image: "")
    ]
    
    @Published var clothes: [Items] =
    [
        Items(name: "", image: "")
    ]
    
    @Published var shops: [Items] =
    [
        Items(name: "", image: "")
    ]
    
    func get_items(categoryName: String) -> [Items] {
        switch categoryName {
        case "animals":
            return animals
        case "food":
            return food
        case "clothes":
            return clothes
        case "shops":
            return shops
        default:
            return empty
        }
    }
}
