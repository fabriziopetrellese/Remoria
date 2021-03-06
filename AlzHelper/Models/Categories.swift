//
//  DatabaseModel.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

let itemsCollection = Bundle.main.decode([Item].self, from: "items.json")

struct Category: Identifiable {
    
    enum Name: String, Codable {
        case categories
        case animals
        case ocean_animals
        case fish
        case birds
        case amphibians
        case insects
        case reptiles
        case arachnids
        case mollusks
        case annelids
        case food
        case music
        case household
        case technology
        case recreation
        case clothing
        case automotive
        case building
        case store
        case weapon
        case landscape
        case fashion_accessory
        case work_gear
        case office
        case medical
        case outdoor_structure
        case vegetation
        case random
    }
    
    let id = UUID()
    let name: String
    let image: String
    let color: Color
    
    static func getCategoryName(for label: String) -> String {
        for item in itemsCollection {
            if item.label == label {
                return String(format: NSLocalizedString(item.category, comment: ""))
            }
        }
        
        return "Uncategorized"
    }
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

class Items: ObservableObject {
    
    private init() {}
    
    static let sampleItems = Items.getItems(for: "animals")
    
    //for
    class func getItems(for category: String) -> [Item] {
        var items = [Item]()
        
        for item in itemsCollection {
            if items.count == 20 { return items } // set max number of items to retrieve
            if category == item.category { items.append(item) }
        }

        return items
    }
    
    // for keyword search
    class func getItems(using keyword: String) -> [Item] {
        var items = [Item]()

        for item in itemsCollection {
            if items.count == 20 { return items } // set max number of items to retrieve
            if item.label == keyword { items.append(item) }
            if item.category == keyword { items.append(item) }
            if let tags = item.tags, tags.contains(keyword) {
                items.append(item)
            }
        }
        
        return items
    }
}
