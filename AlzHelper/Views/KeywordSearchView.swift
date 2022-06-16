//
//  KeywordsSearchView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 07/06/22.
//

import SwiftUI

struct KeywordsSearchView: View {
    @EnvironmentObject var categories: Categories
    @State private var searchText = ""
    
    let keywords: LocalizedStringKey = "keywords"
    let typeKeyword: LocalizedStringKey = "typeKeyword"
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var searchResults: [Item] {
        if searchText.isEmpty {
            return categories.itemsCollection
        } else {
            return categories.itemsCollection.filter { $0.tags!.contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(searchResults) { item in
                        NavigationLink {
                            GuessView(item: item)
                        } label: {
                            ItemView(imageUrl: item.imageUrl!)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(keywords)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: typeKeyword)
    }
}

struct KeywordsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordsSearchView()
    }
}
