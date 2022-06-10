//
//  DatabaseModel.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

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
    var imageUrl: String? // Library Category Image Url path
//    var tags: [String]
    
    // for previews
    static let sampleItem = Bundle.main.decode([Item].self, from: "items.json").first!
}

class Categories: ObservableObject {
    @Published var itemsCollection = Bundle.main.decode([Item].self, from: "items.json")
    
    @Published var categories = [Category]()
    
    @Published var animals = [Item]()
    @Published var food = [Item]()
    @Published var music = [Item]()
    @Published var house = [Item]()
    @Published var technology = [Item]()
    @Published var sport = [Item]()
    @Published var clothes = [Item]()
    @Published var vehicles = [Item]()
    @Published var buildings = [Item]()
    
    func getCategories() {
        for i in 0..<itemsCollection.count {
            switch itemsCollection[i].category {
            case "animals":
                animals.append(itemsCollection[i])
            case "food":
                food.append(itemsCollection[i])
            case "music":
                music.append(itemsCollection[i])
            case "house":
                house.append(itemsCollection[i])
            default:
                return
            }
        }
        appendCategories()
    }
    
    func appendCategories() {
        categories.append(Category(name: "animals", image: "🐶", color: .red, items: animals))
        categories.append(Category(name: "food", image: "🍽", color: .blue, items: food))
    }
}






