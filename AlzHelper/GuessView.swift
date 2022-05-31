//
//  GuessView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct GuessView: View {
    @EnvironmentObject var navigationRoot: NavigationRoot
    @State var name: String = ""
    @State var index: Int = 0
    @State var correctAlert: Bool = false
    @State var wrongAlert: Bool = false
    let itemName: String
    let itemImage: String
    let itemCategory: String

    
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
//        name = name.uppercased()
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
            VStack {
                //            ScrollView(showsIndicators: false) {
                Image(itemImage)
                    .resizable()
                    .frame(width: 350, height: 250)
                
                Text("This belongs to: " + itemCategory.capitalized)
                    .font(.title)
                    .bold()
                    .padding(.top, 24)
                
                TextField("", text: $name)
                    .font(.title.bold())
                    .padding(.horizontal, 12)
                    .frame(width: 0.77 * UIScreen.main.bounds.width, height: 60)
                    .border(.black)
                    .padding(.top, 12)
                    .disableAutocorrection(true)
                
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
                .padding(.top, 20)
                .padding(.bottom, 40)
//            }
                Spacer()
            }
        .onAppear() {
            showFirstCharacter()
        }
        .onChange(of: name) { newValue in
            if newValue.count == itemName.count {
                guessWord()
            }
        }
        .alert("Correct!", isPresented: $correctAlert, actions: {
            Button("Main screen", role: .none, action: { navigationRoot.exit() })
//            Button {
//                navigationRoot.exit()
//            } label: {
//                Text("Main screen")
//            }
        }, message: {
            Text("Go back to main screen to identify new objects.")
        })
        .alert("Nice try!", isPresented: $wrongAlert, actions: {
            Button("Try again", role: .cancel, action: {})
        }, message: {
            Text("Almost done, you are very close.")
        })
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(itemName: "dog", itemImage: "Dog", itemCategory: "animals")
            .environmentObject(NavigationRoot())
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
