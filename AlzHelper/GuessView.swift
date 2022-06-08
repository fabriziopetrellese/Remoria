//
//  GuessView.swift
//  AlzHelper
//
//  Created by Valerio Domenico Conte on 30/05/22.
//

import SwiftUI

struct GuessView: View {
    // Navigation to Main Menu
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationRoot: NavigationRoot
    
    @StateObject var imagePredictor = ImagePredictor()
    
    @State var name: String = ""
    @State var index: Int = 0
    @State var correctAlert: Bool = false
    @State var wrongAlert: Bool = false
    
    // passed in from library view
    @State var isLibrary: Bool = false
    
    // passed in from content view when user takes a photo
    @State var itemUiImage: UIImage?
    
    // passed in from libary view or set by image predictor for user photos
    @State var item: Item?
    
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
            
            // set image view if Library image
            if isLibrary, let imageUrl = item?.imageUrl {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
            // set image view if user photo
            } else if let image = itemUiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
            }
            
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
            if isLibrary {
                showFirstCharacter()
                return
            }
            
            if let image = itemUiImage {
                imagePredictor.userSelectedPhoto(image)
            }
        }
        
        // Construct Item when image is classified
        .onChange(of: imagePredictor.predictionText) { newValue in
            guard !isLibrary else { return }
            self.item = Item(
                id: 0,
                label: newValue,
                //TODO: Set Category
                category: "Some Category"
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
    
    private func dismissView() {
        isLibrary ? navigationRoot.exit() : self.dismiss()
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(
            itemUiImage: nil,
            item: Item.sampleItem
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
