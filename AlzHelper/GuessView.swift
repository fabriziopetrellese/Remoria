//
//  GuessView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct GuessView: View {
    @Environment(\.dismiss) var dismissView
    @StateObject var imagePredictor = ImagePredictor()
    
    @State var name: String = ""
    @State var index: Int = 0
    @State var correctAlert: Bool = false
    @State var wrongAlert: Bool = false
    
    @State var isLibrary: Bool = false
    
    // set by image predictor after a prediction is made
    @State var item: Item?
    
    // passed in from content view when user selects an image
    @State var itemUiImage: UIImage?

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
        VStack(spacing: 20) {
            let imageView: Image = {
                if let image = itemUiImage {
                    return Image(uiImage: image)
                    
                } else {
                    return Image("Dog")
                }
            }()
            
            imageView
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
            
            Text("Item Category:\n" + (item?.category.capitalized ?? "Not Classified"))
                .font(.title3)
                .bold()
                .frame(alignment: .center)
            
            TextField("", text: $name)
                .textFieldStyle(.roundedBorder)
                .font(.title.bold())
                .padding(.horizontal, 12)
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
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Guess this object")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            if let image = itemUiImage {
                imagePredictor.userSelectedPhoto(image)
            }
            
            if isLibrary {
                item = Item.sampleItem
                showFirstCharacter()
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
            if newValue.count == item?.label.count {
                guessWord()
            }
            
        }
        .alert("Correct!", isPresented: $correctAlert, actions: {
            Button("Main screen", role: .none) {
                dismissView()
            }

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
