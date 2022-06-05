//
//  CategoryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var categoriesModel: DatabaseDecoder
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
        CategoryView(categoryName: "animals", categoryItems: DatabaseDecoder().animals)
            .environmentObject(DatabaseDecoder())
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
