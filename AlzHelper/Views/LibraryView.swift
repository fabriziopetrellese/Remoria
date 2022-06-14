//
//  LibraryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.dismiss) var dismissView
    @EnvironmentObject var categoriesModel: Categories
    @State private var searchText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    let library: LocalizedStringKey = "library"
    let browseCategories: LocalizedStringKey = "browseCategories"
    
    var searchResults: [Category] {
        if searchText.isEmpty {
            return categoriesModel.categories
        } else {
            return categoriesModel.categories.filter { String(format: NSLocalizedString($0.name, comment: "")).contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(searchResults) { category in
                        NavigationLink {
                            CategoryView(categoryName: String(format: NSLocalizedString(category.name, comment: "")),
                                         categoryItems: category.items)
                        } label: {
                            CardView(label: String(format: NSLocalizedString(category.name, comment: "")).capitalized,
                                     pic: category.image,
                                     color: category.color)
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
//            .environmentObject(Categories())
//    }
//}

struct CardView: View {
    let label: String
    let pic: String
    let color: Color
    
    var body: some View {
        ZStack {
            Image("libraryCard")

            Text(pic)
                .font(.largeTitle)
                .padding(.bottom, 23)
            
            Text(label)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .frame(width: 150, alignment: .leading)
                .padding(.top, 80)
                .padding(.trailing, 10)
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(label: "Animali marini", pic: "🐍", color: .lightPurple)
            .environmentObject(Categories())
    }
}
