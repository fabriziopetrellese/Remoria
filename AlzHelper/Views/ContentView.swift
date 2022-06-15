//
//  ContentView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationRoot = NavigationRoot()
    @EnvironmentObject var categories: Categories
    @State var showModal: Bool = false
    
    //navigation triggers
    @State private var isLibraryViewActive = false
    @State private var isGuessViewActive: Bool = false
    
    //camera view properties
    @State private var isCameraViewPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    let mainMenu: LocalizedStringKey = "mainMenu"
    let takePhoto: LocalizedStringKey = "takePhoto"
    let chooseLibrary: LocalizedStringKey = "chooseLibrary"
    let searchKeywords: LocalizedStringKey = "searchKeywords"
    
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
                    title: takePhoto,
                    icon: "camera.fill",
                    color: .red,
                    shadowRadius: 4
                )
                .onTapGesture {
                    isCameraViewPresented.toggle()
                }
                
                //Present Library View
                NavigationLink(
                    destination: LibraryView(),
                    isActive: $isLibraryViewActive
                ) {
                    ButtonView(title: chooseLibrary,
                               icon: "photo.on.rectangle.angled",
                               color: .blue,
                               shadowRadius: 4
                    )
                }
                .isDetailLink(false)
                
                NavigationLink {
                    KeywordsSearchView()
                } label: {
                    ButtonView(title: searchKeywords,
                               icon: "keyboard.fill",
                               color: .yellow,
                               shadowRadius: 4
                    )
                }
            }
            .padding(.bottom, 40)
            .navigationTitle(mainMenu)
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
        .onReceive(navigationRoot.$backToRoot) { newValue in
            if newValue {
                isLibraryViewActive = false
                navigationRoot.backToRoot = false
            }
        }
        .environmentObject(navigationRoot)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Categories())
    }
}
