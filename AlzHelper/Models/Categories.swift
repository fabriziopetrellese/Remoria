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
    let itemsCollection = Bundle.main.decode([Item].self, from: "items.json")
    
    var categories = [Category]()
    var animals = [Item]()
    var ocean_animals = [Item]()
    var fish = [Item]()
    var birds = [Item]()
    var amphibians = [Item]()
    var insects = [Item]()
    var reptiles = [Item]()
    var arachnids = [Item]()
    var mollusks = [Item]()
    var food = [Item]()
    var music = [Item]()
    var house = [Item]()
    var technology = [Item]()
    var sport = [Item]()
    var clothes = [Item]()
    var vehicles = [Item]()
    var buildings = [Item]()
    
    func getCategories() async {
        for i in 0..<itemsCollection.count {
            
            var item = itemsCollection[i]
            
            switch itemsCollection[i].category {
            case "animals":
                if animals.count == 20 { continue }
                item.imageUrl = await NetworkManager.shared.getItemImageUrl(using: (categoryName: item.category, label: item.label))
                animals.append(item)
                
            case "ocean animals":
                ocean_animals.append(item)
            case "fish":
                fish.append(item)
            case "birds":
                birds.append(item)
            case "amphibians":
                amphibians.append(item)
            case "insects":
                insects.append(item)
            case "reptiles":
                reptiles.append(item)
            case "arachnids":
                arachnids.append(item)
            case "mollusks":
                mollusks.append(item)
            case "food":
                food.append(item)
            case "music":
                music.append(item)
            case "house":
                house.append(item)
            case "technology":
                technology.append(item)
            case "sport":
                sport.append(item)
            case "clothes":
                clothes.append(item)
            case "vehicles":
                vehicles.append(item)
            case "buildings":
                buildings.append(item)
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
    
    func photoCategory(label: String) -> String {
        for i in 0..<itemsCollection.count {
            if itemsCollection[i].label == label {
                return String(format: NSLocalizedString(itemsCollection[i].category, comment: ""))
            }
        }
        return "Some category"
    }
}
