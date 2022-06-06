//
//  ContentView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var db: DatabaseDecoder
    @State var showModal: Bool = false
    
    //navigation triggers
    @State private var isLibraryViewActive = false
    @State private var isGuessViewActive: Bool = false
    
    //camera view properties
    @State private var isCameraViewPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                
                //Present Guess View
                NavigationLink(
                    destination: GuessView(itemUiImage:selectedImage),
                    isActive: $isGuessViewActive
                ) {}
                
                //Present Camera View
                ButtonView(
                    title: "Take a photo",
                    icon: "camera.fill",
                    color: .red
                )
                .onTapGesture {
                    isCameraViewPresented.toggle()
                }
                
                //Present Library View
                NavigationLink(
                    destination: LibraryView(),
                    isActive: $isLibraryViewActive
                ) {
                    ButtonView(title: "Choose from the Library", icon: "photo.on.rectangle.angled", color: .blue)
                }
                .isDetailLink(false)
                
                NavigationLink {
                } label: {
                    ButtonView(title: "Search by key-words", icon: "keyboard.fill", color: .yellow)
                }
                
                Spacer()
            }
            .navigationTitle("Main Menu")
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
            .fullScreenCover(isPresented: self.$isCameraViewPresented) {
                ImagePickerView(
                    selectedImage: self.$selectedImage,
                    sourceType: .camera
                )
                .ignoresSafeArea()
            }
        }
        .onChange(of: selectedImage) { newValue in
            guard newValue != nil else { return }
            isGuessViewActive.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DatabaseDecoder())
    }
}
