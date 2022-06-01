//
//  DatabaseModel.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import Foundation
import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let color: Color
    let items: [Item]
}

struct Item: Codable, Identifiable {
    var id: Int
    var label: String
    var category: String
    var image: String
    
    // for previews
    static let sampleItem = Bundle.main.decode([Item].self, from: "items.json").first!
}

class DatabaseDecoder: ObservableObject {
    @Published var itemsCollection = Bundle.main.decode([Item].self, from: "items.json")
    @Published var categories = [Category]()
    @Published var animals = [Item]()
    @Published var food = [Item]()
    
    func get_categories() {
        for i in 0..<itemsCollection.count {
            switch itemsCollection[i].category {
            case "animals":
                animals.append(itemsCollection[i])
            case "food":
                food.append(itemsCollection[i])
            default:
                return
            }
        }
        append_categories()
    }
    
    func append_categories() {
        categories.append(Category(name: "animals", image: "🐶", color: .red, items: animals))
        categories.append(Category(name: "food", image: "🍽", color: .blue, items: food))
    }
}






