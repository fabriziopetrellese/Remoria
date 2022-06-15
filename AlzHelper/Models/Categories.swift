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
    @Published var annelids = [Item]()

    @Published var food = [Item]()
    @Published var music = [Item]()
    @Published var household = [Item]()
    @Published var technology = [Item]()
    @Published var recreation = [Item]()
    @Published var clothing = [Item]()
    @Published var automotive = [Item]()
    @Published var building = [Item]()
    @Published var store = [Item]()
    @Published var weapon = [Item]()
    @Published var landscape = [Item]()
    @Published var fashion_accessory = [Item]()
    @Published var work_gear = [Item]()
    @Published var office = [Item]()
    @Published var medical = [Item]()
    @Published var outdoor_structure = [Item]()
    @Published var vegetation = [Item]()
    @Published var random = [Item]()
    
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
            case "annelids":
                annelids.append(itemsCollection[i])
            case "food":
                food.append(itemsCollection[i])
            case "music":
                music.append(itemsCollection[i])
            case "household":
                household.append(itemsCollection[i])
            case "technology":
                technology.append(itemsCollection[i])
            case "recreation":
                recreation.append(itemsCollection[i])
            case "clothing":
                clothing.append(itemsCollection[i])
            case "automotive":
                automotive.append(itemsCollection[i])
            case "building":
                building.append(itemsCollection[i])
            case "store":
                store.append(itemsCollection[i])
            case "weapon":
                weapon.append(itemsCollection[i])
            case "landscape":
                landscape.append(itemsCollection[i])
            case "fashion_accessory":
                fashion_accessory.append(itemsCollection[i])
            case "work_gear":
                work_gear.append(itemsCollection[i])
            case "office":
                office.append(itemsCollection[i])
            case "medical":
                medical.append(itemsCollection[i])
            case "outdoor_structure":
                outdoor_structure.append(itemsCollection[i])
            case "vegetation":
                vegetation.append(itemsCollection[i])
            case "random":
                random.append(itemsCollection[i])
                
            default:
                print("ERROR")
                print(itemsCollection[i].label)
            }
        }
        appendCategories()

    }
    
    func appendCategories() {
        categories.append(Category(name: "animals", image: "animals", color: .lightPurple, items: animals))
        categories.append(Category(name: "ocean animals", image: "oceanAnimals", color: .lightPurple, items: ocean_animals))
        categories.append(Category(name: "fish", image: "fish", color: .lightPurple, items: fish))
        categories.append(Category(name: "birds", image: "birds", color: .lightPurple, items: birds))
        categories.append(Category(name: "amphibians", image: "amphibians", color: .lightPurple, items: amphibians))
        categories.append(Category(name: "insects", image: "insects", color: .lightPurple, items: insects))
        categories.append(Category(name: "reptiles", image: "reptiles", color: .lightPurple, items: reptiles))
        categories.append(Category(name: "arachnids", image: "arachnids", color: .lightPurple, items: arachnids))
        categories.append(Category(name: "mollusks", image: "mollusks", color: .lightPurple, items: mollusks))
        categories.append(Category(name: "annelids", image: "annelids", color: .lightPurple, items: annelids))
        
        categories.append(Category(name: "food", image: "food", color: .lightPurple, items: food))
        categories.append(Category(name: "music", image: "music", color: .lightPurple, items: music))
        categories.append(Category(name: "household", image: "household", color: .lightPurple, items: household))
        categories.append(Category(name: "technology", image: "technology", color: .lightPurple, items: technology))
        categories.append(Category(name: "recreation", image: "recreation", color: .lightPurple, items: recreation))
        categories.append(Category(name: "clothing", image: "clothing", color: .lightPurple, items: clothing))
        categories.append(Category(name: "automotive", image: "automotive", color: .lightPurple, items: automotive))
        categories.append(Category(name: "store", image: "store", color: .lightPurple, items: store))
        categories.append(Category(name: "weapon", image: "weapon", color: .lightPurple, items: weapon))
        categories.append(Category(name: "landscape", image: "landscape", color: .lightPurple, items: landscape))
        categories.append(Category(name: "fashion accessory", image: "fashionAccessory", color: .lightPurple, items: fashion_accessory))
        categories.append(Category(name: "work gear", image: "workGear", color: .lightPurple, items: work_gear))
        categories.append(Category(name: "medical", image: "medical", color: .lightPurple, items: medical))
        categories.append(Category(name: "outdoor structure", image: "outdoorStructure", color: .lightPurple, items: outdoor_structure))
        categories.append(Category(name: "vegetation", image: "vegetation", color: .lightPurple, items: vegetation))
        categories.append(Category(name: "random", image: "random", color: .lightPurple, items: random))
        categories.append(Category(name: "building", image: "building", color: .lightPurple, items: building))
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
