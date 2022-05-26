//
//  ContentView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink {
                    //                  CameraView()
                } label: {
                    ButtonView(title: "Take a photo")
                }
                
                Text("or")
                
                NavigationLink {
                    //                  GalleryView()
                } label: {
                    ButtonView(title: "Choose from library")
                }
                
                
            }
            .navigationTitle("AlzHelper")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        //                      InfoView()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonView: View {
    let title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.orange)
                .frame(width: 280, height: 80)
            
            Text(title)
                .foregroundColor(.white)
            
        }
    }
}
