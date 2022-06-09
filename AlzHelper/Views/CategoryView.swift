//
//  CategoryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var categoriesModel: Categories
    let categoryName: String
    let categoryItems: [Item]
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(categoryItems) { item in
                        NavigationLink {
                            GuessView(
                                itemUiImage: nil,
                                item: item
                            )
                        } label: {
                            ItemView(imageUrl: item.imageUrl!)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(categoryName.capitalized)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(categoryName: "animals", categoryItems: Categories().animals)
            .environmentObject(Categories())
    }
}

struct ItemView: View {
    let imageUrl: String
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: self.imageUrl),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 120)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}
