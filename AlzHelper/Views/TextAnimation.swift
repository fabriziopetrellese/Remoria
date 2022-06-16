//
//  TextAnimation.swift
//  AlzHelper
//
//  Created by Fabrizio Petrellese on 12/06/22.
//

import SwiftUI

struct TextAnimation: View {
    
    @State var firstTextLine: String = ""
    @State var secondTextLine: String = ""
    @State var hasPresentedFirstText = false
    @State var hasPresentedSecondText = false
    
    var first: String
    var second: String
    var delay: Double
    var delaySecond: Double
    
    var body: some View {
        ZStack {
            Text(firstTextLine)
                .font(.largeTitle)
                .fontWeight(.medium)
                .animation(.easeIn.delay(delay))
                .frame(width: 350, height: 175, alignment: .center)
                .padding(.bottom)

            Text(secondTextLine)
                .font(.largeTitle)
                .fontWeight(.medium)
                .animation(.easeIn.delay(delaySecond))
                .frame(width: 365, height: 175, alignment: .center)
                .padding(.top, 75)
        }
        .onAppear() {
            guard hasPresentedFirstText == false else {return}
            String(format: NSLocalizedString(first, comment: "")).enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.040) {
                    firstTextLine += String(character)
                }
            }
            hasPresentedFirstText = true
        }
        .onAppear() {
            guard hasPresentedSecondText == false else {return}
            String(format: NSLocalizedString(second, comment: "")).enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.040) {
                    secondTextLine += String(character)
                }
            }
            hasPresentedSecondText = true
        }
    }
}

struct TextAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TextAnimation(first: " Make sure the object", second: " is prominent", delay: 1.0, delaySecond: 1.95)
    }
}



// A modifier that animates a font through various sizes.
struct AnimatableSystemFontModifier: ViewModifier, Animatable {
    var size: Double
    var weight: Font.Weight
    var design: Font.Design

    var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

// To make it easier to use, wrap it in an extension
extension View {
    func animatableSystemFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}
