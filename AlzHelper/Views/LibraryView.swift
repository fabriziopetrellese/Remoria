//
//  LibraryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.dismiss) var dismissView
    
    let categories = [
        Category(name: "animals", image: "animals"),
        Category(name: "ocean animals", image: "oceanAnimals"),
        Category(name: "fish", image: "fish"),
        Category(name: "birds", image: "birds"),
        Category(name: "amphibians", image: "amphibians"),
        Category(name: "insects", image: "insects"),
        Category(name: "reptiles", image: "reptiles"),
        Category(name: "arachnids", image: "arachnids"),
        Category(name: "mollusks", image: "mollusks"),
        Category(name: "annelids", image: "annelids"),
        Category(name: "food", image: "food"),
        Category(name: "music", image: "music"),
        Category(name: "household", image: "household"),
        Category(name: "technology", image: "technology"),
        Category(name: "recreation", image: "recreation"),
        Category(name: "clothing", image: "clothing"),
        Category(name: "automotive", image: "automotive"),
        Category(name: "store", image: "store"),
        Category(name: "weapon", image: "weapon"),
        Category(name: "landscape", image: "landscape"),
        Category(name: "fashion accessory", image: "fashionAccessory"),
        Category(name: "work gear", image: "workGear"),
        Category(name: "medical", image: "medical"),
        Category(name: "outdoor structure", image: "outdoorStructure"),
        Category(name: "vegetation", image: "vegetation"),
        Category(name: "random", image: "random"),
        Category(name: "building", image: "building")
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
        .background(
        Image("background")
            .opacity(0.07)
            .position(x: 207, y: 450)
            .ignoresSafeArea()
        )
        .navigationTitle(library)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: browseCategories)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

struct CardView: View {
    let label: String
    let pic: String
    
    var body: some View {
        ZStack {
            Image(pic)
                .resizable()
            
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

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(label: "Animali marini", pic: "🐍")
//    }
//}
