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
    let image: Image?

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
                if let image = image {
                    image
                        .resizable()
                        .frame(width: 350, height: 250)
                    
                } else {
                    Image(itemImage)
                        .resizable()
                        .frame(width: 350, height: 250)
                }
                
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
            image: nil
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

extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
