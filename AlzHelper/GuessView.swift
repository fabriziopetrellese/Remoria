//
//  GuessView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct GuessView: View {
    @EnvironmentObject var navigationRoot: NavigationRoot
    @StateObject var imagePredictor = ImagePredictor()
    
    @State var name: String = ""
    @State var index: Int = 0
    @State var correctAlert: Bool = false
    @State var wrongAlert: Bool = false
    
    // set by image predictor after a prediction is made
    @State var item: Item?
    
    // passed in from content view when user selects an image
    let itemUiImage: UIImage?

    private func showFirstCharacter() {
        guard let item = self.item else { return }
        var new: Character
        new = item.label.first!
        name.append(new)
        name = name.uppercased()
    }
    
    private func addCharacter() {
        guard let item = self.item else { return }
        index += 1
        var add: String
        add = item.label[index]
        name.append(add)
    }
    
    func showName() {
        guard let item = self.item else { return }
        name = item.label
        name = name.capitalized
    }
    
    func guessWord() {
        guard let item = self.item else { return }
        if name.lowercased() == item.label.lowercased() {
            correctAlert = true
        } else {
            wrongAlert = true
        }
    }
    
    var body: some View {
        VStack {
            let imageView: Image = {
                if let image = itemUiImage {
                    return Image(uiImage: image)
                    
                } else {
                    return Image("Dog")
                }
            }()
            
            imageView
                .resizable()
                .frame(width: 350, height: 250)
            
            Text("This belongs to: " + (item?.category.capitalized ?? "Not Classified"))
                .font(.title)
                .bold()
                .padding(.top, 24)
            
            TextField("", text: $name)
                .textFieldStyle(.roundedBorder)
                .font(.title.bold())
                .padding(.horizontal, 12)
                .frame(width: 0.77 * UIScreen.main.bounds.width, height: 60)
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
            Spacer()
        }
        .onAppear() {
            if let image = itemUiImage {
                imagePredictor.userSelectedPhoto(image)
            }
        }
        
        // Construct Item when image is classified
        .onChange(of: imagePredictor.predictionText) { newValue in
            self.item = Item(
                id: 0,
                label: newValue,
                //TODO: Set Category
                category: "Some Category",
                image: ""
            )
            
            showFirstCharacter()
        }
        .onChange(of: self.name) { newValue in
            if newValue.lowercased() == item?.label.lowercased() {
                guessWord()
            }
        }
        .alert("Correct!", isPresented: $correctAlert, actions: {
            Button("Main screen", role: .none, action: { navigationRoot.exit() })

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
        GuessView(
            item: Item.sampleItem,
            itemUiImage: nil
        )
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


