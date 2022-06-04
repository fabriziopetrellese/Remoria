//
//  AlzHelperApp.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

@main
struct AlzHelperApp: App {
    @StateObject var db = DatabaseDecoder()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    db.get_categories()
                }
                .environmentObject(db)
        }
    }
}
