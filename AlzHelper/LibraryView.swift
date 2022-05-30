//
//  LibraryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var categoriesModel: CategoriesModel
    @State private var searchText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var searchResults: [Category] {
        if searchText.isEmpty {
            return categoriesModel.categories
        } else {
            return categoriesModel.categories.filter { $0.name.contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(searchResults) { category in
                        NavigationLink {
                            CategoryView(categoryName: category.name)
                        } label: {
                            CardView(label: category.name.capitalized, pic: category.image, color: category.color)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Library")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Browse categories")
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(CategoriesModel())
    }
}

struct CardView: View {
    let label: String
    let pic: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 180, height: 120)
                .foregroundColor(color)
                .shadow(radius: 5)

            Text(pic)
                .font(.largeTitle)
            
            Text(label)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .frame(width: 150, alignment: .leading)
                .padding(.top, 80)
            
        }
    }
}
