//
//  CategoryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var categoriesModel: CategoriesModel
    let categoryName: String
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(categoriesModel.get_items(categoryName: categoryName)) { item in
                        NavigationLink {
                            GuessView(
                                itemName: item.name,
                                itemImage: item.image,
                                itemCategory: categoryName,
                                itemUiImage: nil
                            )
                        } label: {
                            ItemView(pic: item.image)
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
        CategoryView(categoryName: "animals")
            .environmentObject(CategoriesModel())
    }
}

struct ItemView: View {
    let pic: String
    
    var body: some View {
        ZStack {
            Image(pic)
                .resizable()
                .frame(width: 180, height: 120)
                .cornerRadius(10)
                .shadow(radius: 5)
                        
        }
    }
}
