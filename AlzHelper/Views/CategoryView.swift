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
                        NavigationLink {
                            GuessView(
                                itemUiImage: nil,
                                item: item
                            )
                        } label: {
                            if let imageUrl = item.imageUrl {
                                ItemView(imageUrl: imageUrl)
                            }
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
