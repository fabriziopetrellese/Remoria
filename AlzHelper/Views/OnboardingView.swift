//
//  OnboardingView.swift
//  AlzHelper
//
//  Created by Simon Italia on 03/06/22.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
    @Binding var showModal: Bool
    @Environment(\.dismiss) var done
    let doneButton: LocalizedStringKey = "done"
    
    var body: some View {
        NavigationView {
            TabView {
                FirstPage(showModal: $showModal,
                          shouldShowOnboarding: $shouldShowOnboarding)
                
                SecondPage(showModal: $showModal,
                           shouldShowOnboarding: $shouldShowOnboarding)
                
                ThirdPage(showModal: $showModal,
                          shouldShowOnboarding: $shouldShowOnboarding)
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupAppearance()
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        done()
                    } label: {
                        Text(doneButton)
                            
                    }
                }
            }
        }
    }
}

func setupAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = .black
    UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
}

struct FirstPage: View {
    @Binding var showModal: Bool
    let takePhoto: LocalizedStringKey = "takePhoto"
    @Binding var shouldShowOnboarding: Bool
    @State var opacity: Double = 0
    @State var secondLineOpacity: Double = 0
     
    var body: some View {
            ZStack {
                Text(takePhoto)
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .padding(.bottom, 590)
                
                ButtonView(title: "",
                           icon: "",
                           color: .red,
                           card: "firstCard"
                )
                .padding(.bottom, 238)
                
                Image(systemName: "camera.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .padding(.bottom, 240)
                
                Text("???")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.trailing, 318.5)
                    .padding(.top, 70)
                    .padding(.trailing, 35)
                    .opacity(opacity)
                    .onAppear() {
                        withAnimation(.linear.delay(0.8)) {
                            opacity = 1
                        }
                    }
                
                TextAnimation(first: "first",
                              second: "second",
                              delay: 1.0,
                              delaySecond: 1.95)
                .padding(.top, 90)
                //            .padding(.leading)
                
                Text("???")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.trailing, 318.5)
                    .padding(.top, 320)
                    .padding(.trailing, 35)
                    .opacity(secondLineOpacity)
                    .onAppear() {
                        withAnimation(.linear.delay(3.8)) {
                            secondLineOpacity = 1
                        }
                    }
                
                TextAnimation(first: "first2",
                              second: "second2",
                              delay: 4,
                              delaySecond: 4.9)
                .padding(.top, 335)
                .padding(.leading)
            }
            .padding(.top, 30)
    }
}

struct SecondPage: View {
    @Binding var showModal: Bool
    @Binding var shouldShowOnboarding: Bool
    @State var opacity: Double = 0
    @State var secondLineOpacity: Double = 0
    
    let chooseLibrary: LocalizedStringKey = "chooseLibrary"
    
    var body: some View {
        ZStack {
            Text(chooseLibrary)
                .font(.system(size: 45))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 150)
                .padding(.bottom, 590)
            
            ButtonView(title: "",
                       icon: "",
                       color: .blue,
                       card: "secondCard"
            )
            .padding(.bottom, 238)
            
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding(.bottom, 240)
            
            TextAnimation(first: "first3",
                          second: "second3",
                          delay: 1.0,
                          delaySecond: 1.95)
            .padding(.top, 90)
            
            Text("???")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.trailing, 318.5)
                .padding(.top, 320)
                .opacity(secondLineOpacity)
                .onAppear() {
                    withAnimation(.linear.delay(3.8)) {
                        secondLineOpacity = 1
                    }
                }
            
            TextAnimation(first: "first4",
                          second: "second4",
                          delay: 4,
                          delaySecond: 4.9
            )
            .padding(.top, 335)
        }
        .padding(.top, 30)
    }
}

struct ThirdPage: View {
    @Binding var showModal: Bool
    @Binding var shouldShowOnboarding: Bool
    @State private var fontSize = 0.1
    @State var opacity: Double = 0
    
    let searchKeywords: LocalizedStringKey = "searchKeywords"
    let first5: LocalizedStringKey = "first5"
    
    var body: some View {
        ZStack {
            Text(searchKeywords)
                .font(.system(size: 45))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 150)
                .padding(.bottom, 590)
            
            ButtonView(title: "",
                       icon: "",
                       color: .yellow,
                       card: "thirdCard"
            )
            .padding(.bottom, 238)
            
            Image(systemName: "keyboard.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding(.bottom, 240)
            
            Text(first5)
                .font(.system(size: 34))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(width: 340, height: 100)
                .frame(width: 350, height: 170)
                .padding(.top, 90)
            
            Text("???")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.trailing, 318.5)
                .padding(.top, 320)
                .opacity(opacity)
                .onAppear() {
                    withAnimation(.linear.delay(0.7)) {
                        opacity = 1
                    }
                }
            
            TextAnimation(first: "first6",
                          second: "second6",
                          delay: 1.3,
                          delaySecond: 2.2)
            .padding(.top, 335)
        }
        .padding(.top, 30)
        
        
    }
        
}

struct ThirdPage_Previews: PreviewProvider {
    static var previews: some View {
//        FirstPage(showModal: .constant(false))
//            .previewDisplayName("Onboarding 1")
//            .environment(\.locale, .init(identifier: "it"))
        
//        SecondPage(showModal: .constant(false))
//            .previewDisplayName("Onboarding 2")
//            .environment(\.locale, .init(identifier: "it"))
        
        ThirdPage(showModal: .constant(false), shouldShowOnboarding: .constant(false))
            .previewDisplayName("Onboarding 3")
            .environment(\.locale, .init(identifier: "it"))
    }
}
