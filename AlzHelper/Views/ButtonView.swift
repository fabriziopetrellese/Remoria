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
            
            ZStack {
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 240, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 42)

                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .padding(.top, 69)
            }
        }
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Take a photo", icon: "photo.on.rectangle.angled", color: .white, card: "firstCard")
    }
}
