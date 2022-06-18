//
//  LibraryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct LibraryView: View {
    
    let categories = [
        Category(name: "animals", image: "animals", color: .lightPurple),
        Category(name: "ocean animals", image: "oceanAnimals", color: .lightPurple),
        Category(name: "fish", image: "fish", color: .lightPurple),
        Category(name: "birds", image: "birds", color: .lightPurple),
        Category(name: "amphibians", image: "amphibians", color: .lightPurple),
        Category(name: "insects", image: "insects", color: .lightPurple),
        Category(name: "reptiles", image: "reptiles", color: .lightPurple),
        Category(name: "arachnids", image: "arachnids", color: .lightPurple),
        Category(name: "mollusks", image: "mollusks", color: .lightPurple),
        Category(name: "annelids", image: "annelids", color: .lightPurple),
        Category(name: "food", image: "food", color: .lightPurple),
        Category(name: "music", image: "music", color: .lightPurple),
        Category(name: "household", image: "household", color: .lightPurple),
        Category(name: "technology", image: "technology", color: .lightPurple),
        Category(name: "recreation", image: "recreation", color: .lightPurple),
        Category(name: "clothing", image: "clothing", color: .lightPurple),
        Category(name: "automotive", image: "automotive", color: .lightPurple),
        Category(name: "store", image: "store", color: .lightPurple),
        Category(name: "weapon", image: "weapon", color: .lightPurple),
        Category(name: "landscape", image: "landscape", color: .lightPurple),
        Category(name: "fashion accessory", image: "fashionAccessory", color: .lightPurple),
        Category(name: "work gear", image: "workGear", color: .lightPurple),
        Category(name: "medical", image: "medical", color: .lightPurple),
        Category(name: "outdoor structure", image: "outdoorStructure", color: .lightPurple),
        Category(name: "vegetation", image: "vegetation", color: .lightPurple),
        Category(name: "random", image: "random", color: .lightPurple),
        Category(name: "building", image: "building", color: .lightPurple)
    ]
    
    @State private var searchText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 150)), count: 2)
    
    let library: LocalizedStringKey = "library"
    let browseCategories: LocalizedStringKey = "browseCategories"
    
    var searchResults: [Category] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { String(format: NSLocalizedString($0.name, comment: "")).contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchResults) { category in
                        NavigationLink {
                            CategoryView(categoryName: String(format: NSLocalizedString(category.name, comment: "")),
                                         items: Items.getItems(for: category.name))
                        } label: {
                            CardView(label: String(format: NSLocalizedString(category.name, comment: "")).capitalized,
                                     pic: category.image)
                                       .frame(height: 150)
                                     
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(library)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: browseCategories)
    }
}

//struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView()
//    }
//}

struct CardView: View {
    let label: String
    let pic: String
    
    var body: some View {
        ZStack {


            Image(pic)
                .resizable()
                .cornerRadius(12)
            
            Text(label)
                .font(.system(size: 19))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .frame(width: 125, height: 46, alignment: .leading)
                .padding(.top, 100)
                .padding(.trailing, 50)
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(label: "Animali marini", pic: "🐍")
    }
}
