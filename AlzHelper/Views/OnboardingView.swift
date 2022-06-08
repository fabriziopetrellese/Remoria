//
//  OnboardingView.swift
//  AlzHelper
//
//  Created by Simon Italia on 03/06/22.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("Instructions")
                .font(.title)
                .bold()
            
            Text("AlzHelper is an app to help you remember words.")
            
            Text("Start by:")
            
            Text("taking a photo of the object")
            
            Text("or")
            
            Text("choose one from the library")
        }
    }
}
