//
//  AlzHelperApp.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

@main
struct AlzHelperApp: App {
    @StateObject var categories = Categories()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .onAppear {
                    categories.getCategories()
                }
                .environmentObject(categories)
        }
    }
}
