//
//  CardView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 27/05/22.
//

import SwiftUI

struct CardView: View {
    let label: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 180, height: 180)
                .foregroundColor(.blue)
            
            Text(label)
                .foregroundColor(.white)
        }
        .padding(.top, 32)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(label: "Label")
    }
}
