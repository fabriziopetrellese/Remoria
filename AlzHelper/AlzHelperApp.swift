//
//  AlzHelperApp.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

@main
struct AlzHelperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CategoriesModel())
        }
    }
}
