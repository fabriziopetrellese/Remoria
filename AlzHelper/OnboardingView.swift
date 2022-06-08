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
            ZeroPageView(showModal: $showModal)
            
            FirstPageView(showModal: $showModal)
            
            SecondPageView(showModal: $showModal)
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

struct ZeroPageView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("First page")
        }
    }
}

struct FirstPageView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("Second page")
        }
    }
}

struct SecondPageView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("Third page")
        }
    }
}

struct ZeroPageView_Previews: PreviewProvider {
    static var previews: some View {
        ZeroPageView(showModal: .constant(false))
    }
}
