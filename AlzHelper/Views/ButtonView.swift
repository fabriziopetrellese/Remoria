//
//  ButtonView.swift
//  AlzHelper
//
//  Created by Simon Italia on 03/06/22.
//

import SwiftUI

struct ButtonView: View {
    let title: LocalizedStringKey
    let icon: String
    let color: Color
    var shadowRadius: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color)
                .frame(width: 280, height: 140)
                .shadow(radius: shadowRadius)
            
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
