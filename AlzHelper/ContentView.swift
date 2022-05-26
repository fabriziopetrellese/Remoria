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
                    ButtonView(title: "Take a photo", icon: "camera", color: .red)
                }
                
                Text("or")
                    .padding(.vertical)
                
                NavigationLink {
//                  GalleryView()
                } label: {
                    ButtonView(title: "Choose from library", icon: "photo.on.rectangle.angled", color: .yellow)
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
    let icon: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color)
                .frame(width: 280, height: 120)
                .shadow(radius: 5)
            
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
            }
        }
    }
}
