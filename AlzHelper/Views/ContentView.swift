//
//  ContentView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationRoot = NavigationRoot()
    @State var showModal: Bool = false
    
    //navigation to child view triggers
    @State private var isLibraryViewActive = false
    @State private var isKeywordSearchViewActive: Bool = false
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
            
            VStack(spacing: 47) {
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
                    card: "firstCard"
                )
                .onTapGesture {
                    isCameraViewPresented.toggle()
                }
                
                //Present Library View
                NavigationLink(
                    destination: LibraryView(),
                    isActive: $isLibraryViewActive
                ){
                    ButtonView(title: chooseLibrary,
                               icon: "photo.on.rectangle.angled",
                               color: .blue,
                               card: "secondCard"
                    )
                }.isDetailLink(false)
                
                //Present Keyword Search view
                NavigationLink(
                    destination: KeywordsSearchView(),
                    isActive: $isKeywordSearchViewActive
                ){
                    ButtonView(title: searchKeywords,
                               icon: "keyboard.fill",
                               color: .yellow,
                               card: "thirdCard"
                    )
                }.isDetailLink(false)
            }
            .background(
                Image("background")
                    .opacity(0.1)
                    .ignoresSafeArea()
            )
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
                isKeywordSearchViewActive = false
                navigationRoot.backToRoot = false
            }
        }
        .environmentObject(navigationRoot)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let lightPurple = Color("lightPurple")
}


extension View {
    func dismissKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
