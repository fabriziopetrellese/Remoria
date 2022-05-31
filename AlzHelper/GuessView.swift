//
//  GuessView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct GuessView: View {
    @State var name: String = ""
    @State var index: Int = 0
    @State var correctAlert: Bool = false
    @State var wrongAlert: Bool = false
    let itemName: String
    let itemImage: String
    let itemCategory: String
    let itemUiImage: UIImage?

    func showFirstCharacter() {
        var new: Character
        new = itemName.first!
        name.append(new)
        name = name.uppercased()
    }
    
    func addCharacter() {
        index += 1
        var add: String
        add = itemName[index]
        name.append(add)
    }
    
    func showName() {
        name = itemName
        name = name.uppercased()
    }
    
    func guessWord() {
        if name.lowercased() == itemName {
            correctAlert = true
        } else {
            wrongAlert = true
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 32) {
                
                let imageView: Image = {
                    if let image = itemUiImage {
                        return Image(uiImage: image)

                    } else {
                        return Image(itemImage)
                    }
                }()
                
                imageView
                    .resizable()
                    .frame(width: 350, height: 250)
                    
                Text("This belongs to: " + itemCategory.capitalized)
                    .font(.title)
                    .bold()
                
                TextField("", text: $name)
                    .font(.title.bold())
                    .frame(width: 290, height: 60)
                    .border(.black)
                
                HStack(alignment: .center, spacing: 48) {
                    Button {
                        showName()
                    } label: {
                        GuessButton(action: "Show name")
                    }
                    
                    Button {
                        addCharacter()
                    } label: {
                        GuessButton(action: "Next queue")
                    }
                }
            }
        }
        .onAppear() {
            showFirstCharacter()
            if let image = itemUiImage {
                ImagePredictor.shared.classifyImage(image)
            }
        }
        .onChange(of: name) { newValue in
            if newValue.count == itemName.count {
                guessWord()
            }
        }
        .alert("Guessed!", isPresented: $correctAlert) {
            Button("OK", role: .cancel) {}
        }
        .alert("Wrong!", isPresented: $wrongAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(
            itemName: "dog",
            itemImage: "Dog",
            itemCategory: "animals",
            itemUiImage: nil
        )
        
    }
}

struct GuessButton: View {
    let action: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.white)
                .border(.black)
                .frame(width: 120, height: 40)
            
            Text(action)
                .bold()
                .foregroundColor(.black)
        }
    }
}


