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
    
    enum SourceType: String, Codable {
        case library, photo
    }
    
    var id: Int
    var label: String
    var category: String
    var imageUrl: String? // Library Category Image Url path
    var source: SourceType
    var tags: [String]?
    
    // for previews
    static let sampleItem = Bundle.main.decode([Item].self, from: "items.json").first!
}

class Categories: ObservableObject {
    @Published var itemsCollection = Bundle.main.decode([Item].self, from: "items.json")
    
    @Published var categories = [Category]()
    
    @Published var animals = [Item]()
    @Published var ocean_animals = [Item]()
    @Published var fish = [Item]()
    @Published var birds = [Item]()
    @Published var amphibians = [Item]()
    @Published var insects = [Item]()
    @Published var reptiles = [Item]()
    @Published var arachnids = [Item]()
    @Published var mollusks = [Item]()

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
            case "ocean animals":
                ocean_animals.append(itemsCollection[i])
            case "fish":
                fish.append(itemsCollection[i])
            case "birds":
                birds.append(itemsCollection[i])
            case "amphibians":
                amphibians.append(itemsCollection[i])
            case "insects":
                insects.append(itemsCollection[i])
            case "reptiles":
                reptiles.append(itemsCollection[i])
            case "arachnids":
                arachnids.append(itemsCollection[i])
            case "mollusks":
                mollusks.append(itemsCollection[i])
            case "food":
                food.append(itemsCollection[i])
            case "music":
                music.append(itemsCollection[i])
            case "house":
                house.append(itemsCollection[i])
            case "technology":
                technology.append(itemsCollection[i])
            case "sport":
                sport.append(itemsCollection[i])
            case "clothes":
                clothes.append(itemsCollection[i])
            case "vehicles":
                vehicles.append(itemsCollection[i])
            case "buildings":
                buildings.append(itemsCollection[i])
            default:
                print("ERROR")
                print(itemsCollection[i].label)
            }
        }
        appendCategories()

    }
    
    func appendCategories() {
        categories.append(Category(name: "animals", image: "🐶", color: .lightPurple, items: animals))
        categories.append(Category(name: "ocean animals", image: "🐳", color: .lightPurple, items: ocean_animals))
        categories.append(Category(name: "fish", image: "🐟", color: .lightPurple, items: fish))
        categories.append(Category(name: "birds", image: "🐥", color: .lightPurple, items: birds))
        categories.append(Category(name: "amphibians", image: "🐸", color: .lightPurple, items: amphibians))
        categories.append(Category(name: "insects", image: "🐞", color: .lightPurple, items: insects))
        categories.append(Category(name: "reptiles", image: "🐍", color: .lightPurple, items: reptiles))
        categories.append(Category(name: "arachnids", image: "🦂", color: .lightPurple, items: arachnids))
        categories.append(Category(name: "mollusks", image: "🦑", color: .lightPurple, items: mollusks))
        
        categories.append(Category(name: "food", image: "🍽", color: .lightPurple, items: food))
        categories.append(Category(name: "music", image: "🎹", color: .lightPurple, items: music))
        categories.append(Category(name: "house", image: "🏠", color: .lightPurple, items: house))
        categories.append(Category(name: "technology", image: "💻", color: .lightPurple, items: technology))
        categories.append(Category(name: "sport", image: "⚽️", color: .lightPurple, items: sport))
        categories.append(Category(name: "clothes", image: "👕", color: .lightPurple, items: clothes))
        categories.append(Category(name: "vehicles", image: "🚗", color: .lightPurple, items: vehicles))
        categories.append(Category(name: "buildings", image: "🏬", color: .lightPurple, items: buildings))
    }
}
