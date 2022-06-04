//
//  ContentView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationRoot = NavigationRoot()
    @EnvironmentObject var db: DatabaseDecoder
    @State var isView1Active = false
    @State var showModal: Bool = false
    @State private var isGuessViewActive: Bool = false
    
    //camera view properties
    @State private var isCameraViewPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
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
                .padding(.vertical)
                
                //Present Library View
                NavigationLink(
                    destination: LibraryView()
                        .environmentObject(navigationRoot),
                    isActive: $isView1Active
                ) {
                    ButtonView(title: "Choose from the Library", icon: "photo.on.rectangle.angled", color: .blue)
                }
                .isDetailLink(false)
                .padding(.vertical)
                
                NavigationLink {
                } label: {
                    ButtonView(title: "Search by key-words", icon: "keyboard.fill", color: .yellow)
                }
                .padding(.vertical)
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
            .onReceive(navigationRoot.$backToRoot) { moveToDashboard in
                if moveToDashboard {
                    isView1Active = false
                    navigationRoot.backToRoot = false
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
            .environmentObject(NavigationRoot())
    }
}
