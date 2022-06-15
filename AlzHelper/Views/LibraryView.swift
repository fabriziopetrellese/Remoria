//
//  LibraryView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.dismiss) var dismissView
    @EnvironmentObject var categoriesModel: Categories
    @State private var searchText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 150)), count: 2)
    
    let library: LocalizedStringKey = "library"
    let browseCategories: LocalizedStringKey = "browseCategories"
    
    var searchResults: [Category] {
        if searchText.isEmpty {
            return categoriesModel.categories
        } else {
            return categoriesModel.categories.filter { String(format: NSLocalizedString($0.name, comment: "")).contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchResults) { category in
                        NavigationLink {
                            CategoryView(categoryName: String(format: NSLocalizedString(category.name, comment: "")),
                                         categoryItems: category.items)
                        } label: {
                            CardView(label: String(format: NSLocalizedString(category.name, comment: "")).capitalized,
                                     pic: category.image)
                                       .frame(height: 150)
                                     
                        }
                    }
                }
                .padding()
            }
        }
        .background(
        Image("background")
            .opacity(0.07)
            .position(x: 207, y: 450)
            .ignoresSafeArea()
        )
        .navigationTitle(library)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: browseCategories)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(Categories())
    }
}

struct CardView: View {
    let label: String
    let pic: String
    
    var body: some View {
        ZStack {


            Image(pic)
                .resizable()
            
            Text(label)
                .font(Font.custom("Nexa", size: 20))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .frame(width: 150, alignment: .leading)
                .padding(.top, 90)
                .padding(.trailing, 10)
            
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(label: "Animali marini", pic: "🐍")
//            .environmentObject(Categories())
//    }
//}
