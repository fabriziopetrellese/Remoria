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
    var card: String
    
    var body: some View {
        ZStack {
            
            Image(card)
                .resizable()
                .frame(width: 290, height: 150)
            
            ZStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 240, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 45)

                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .padding(.top, 66)
            }
        }
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Choose from the library", icon: "photo.on.rectangle.angled", color: .white, card: "firstCard")
    }
}
