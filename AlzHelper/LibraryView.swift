//
//  LibraryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var categoriesModel: CategoriesModel
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(categoriesModel.categories) { category in
                        CardView(label: category.name)
                    }
                }
            }
        }
        .navigationTitle("Library")
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(CategoriesModel())
    }
}
