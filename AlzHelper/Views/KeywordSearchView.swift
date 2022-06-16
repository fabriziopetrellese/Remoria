//
//  KeywordsSearchView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 07/06/22.
//

import SwiftUI

struct KeywordsSearchView: View {
    @State private var items = [Item]()
    @State private var searchText: String = ""
    
    let keywords: LocalizedStringKey = "keywords"
    let typeKeyword: LocalizedStringKey = "typeKeyword"
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.items) { item in
                        if let imageUrl = item.imageUrl, !imageUrl.isEmpty {
                            NavigationLink {
                                GuessView(item: item)
                            } label: { ItemView(imageUrl: item.imageUrl!) }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(keywords)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: typeKeyword)
        
        .onChange(of: self.searchText) { newValue in
            if newValue.isEmpty {
                self.items = [Item]()

            } else {
                self.items = Items.getItems(using: searchText.lowercased())
                
                for (index, item) in items.enumerated() {
                    Task {
                        items[index].imageUrl = await NetworkManager.shared.getItemImageUrl(using: (categoryName: item.category, label: item.label))
                    }
                }
            }
        }
    }
}

struct KeywordsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordsSearchView()
    }
}
