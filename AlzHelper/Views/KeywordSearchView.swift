//
//  KeywordsSearchView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 07/06/22.
//

import SwiftUI

struct KeywordsSearchView: View {
    @EnvironmentObject var categories: Items
    @State private var searchText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var searchResults: [Item] {
        if searchText.isEmpty {
            return itemsCollection
        } else {
            return itemsCollection.filter { $0.tags!.contains(searchText.lowercased()) }
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
        .navigationTitle("Keywords")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Type a keyword")
    }
}

struct KeywordsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordsSearchView()
    }
}
