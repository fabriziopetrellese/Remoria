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
        TabView {
            FirstPage(showModal: $showModal)
            
            SecondPage(showModal: $showModal)
            
            ThirdPage(showModal: $showModal)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            setupAppearance()
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
                       shadowRadius: 0
            )
            .padding(.bottom, 238)
            
            Image(systemName: "camera.fill")
                .font(.system(size: 40))
                .padding(.bottom, 230)
            
            Text("•")
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
            
            Text("•")
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
                       shadowRadius: 0
            )
            .padding(.bottom, 238)
            
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 40))
                .padding(.bottom, 230)
            
//            Text("•")
//                .font(.largeTitle)
//                .fontWeight(.medium)
//                .padding(.trailing, 318.5)
//                .padding(.top, 70)
//                .opacity(opacity)
//                .onAppear() {
//                    withAnimation(.linear.delay(0.8)) {
//                        opacity = 1
//                    }
//                }
            
            TextAnimation(first: "first3",
                          second: "second3",
                          delay: 1.0,
                          delaySecond: 1.95)
            .padding(.top, 90)
            .padding(.leading)
            
            Text("•")
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
                          delaySecond: 4.9)
            .padding(.top, 335)
            .padding(.leading)
        }
        .padding(.top, 30)
    }
}

struct ThirdPage: View {
    @Binding var showModal: Bool
    @State private var fontSize = 0.1
    @State var opacity: Double = 0
    
    let searchKeywords: LocalizedStringKey = "searchKeywords"
    let first5: LocalizedStringKey = "first5"
    
    var body: some View {
        ZStack {
            Text(searchKeywords)
                .font(.system(size: 43))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 150)
                .padding(.bottom, 590)
            
            ButtonView(title: "",
                       icon: "",
                       color: .yellow,
                       shadowRadius: 0
            )
            .padding(.bottom, 238)
            
            Image(systemName: "keyboard.fill")
                .font(.system(size: 40))
                .padding(.bottom, 230)
            
            
            Text(first5)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(width: 340, height: 160)
                .animatableSystemFont(size: fontSize)
                .onAppear() {
                    withAnimation(.spring(response: 1.5, dampingFraction: 1.5, blendDuration: 1).delay(1)) {
                        fontSize = 42
                    }
                }
                .frame(width: 350, height: 170)
                .padding(.top, 90)
            
            Text("•")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.trailing, 318.5)
                .padding(.top, 320)
                .opacity(opacity)
                .onAppear() {
                    withAnimation(.linear.delay(3.8)) {
                        opacity = 1
                    }
                }
            
            TextAnimation(first: "first6",
                          second: "second6",
                          delay: 4,
                          delaySecond: 4.9)
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
        
        ThirdPage(showModal: .constant(false))
            .previewDisplayName("Onboarding 3")
            .environment(\.locale, .init(identifier: "en"))
    }
}
