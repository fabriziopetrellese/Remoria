//
//  ContentView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    @State var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    //                  CameraView()
                    
                } label: {
                    ButtonView(title: "Take a photo", icon: "camera.fill", color: .red)
                }
                .padding(.vertical)
                
                NavigationLink {
                    LibraryView()
                } label: {
                    ButtonView(title: "Choose from the Library", icon: "photo.on.rectangle.angled", color: .blue)
                }
                .padding(.vertical)
                
                NavigationLink {
                    //                  KeywordsView()
                } label: {
                    ButtonView(title: "Search by key-words", icon: "keyboard.fill", color: .yellow)
                }
                .padding(.vertical)
            }
            .navigationTitle("AlzHelper")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showModal) {
                        OnboardingView(showModal: $showModal)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CategoriesModel())
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
                .frame(width: 280, height: 140)
                .shadow(radius: 5)
            
            VStack {
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 240, alignment: .center)
                    .multilineTextAlignment(.center)

                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
            }
        }
    }
}

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
