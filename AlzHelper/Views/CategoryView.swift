//
//  CategoryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct CategoryView: View {
    let categoryName: String
    @State var items: [Item]
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(items) { item in
                        if let imageUrl = item.imageUrl, !imageUrl.isEmpty {
                            NavigationLink {
                                GuessView(
                                    itemUiImage: nil,
                                    item: item
                                )
                            } label: { ItemView(imageUrl: imageUrl) }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(String(format: NSLocalizedString(categoryName, comment: "")).capitalized)
        .onAppear  {
            for (index, item) in items.enumerated() {
                Task {
                    items[index].imageUrl = await NetworkManager.shared.getItemImageUrl(using: (categoryName: item.category, label: item.label))
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(
            categoryName: "animals",
            items: Items.sampleItems
        )
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
                        .scaledToFill()
                        .frame(width: 180, height: 160)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}
