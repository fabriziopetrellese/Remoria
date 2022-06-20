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
    
    // passed in from content view when user takes a photo
    @State var itemUiImage: UIImage?
    
    // passed in from libary view or set by image predictor for user photos
    @State var item: Item?
    
    @State var correct: String = ""
    let mainScreen: LocalizedStringKey = "mainScreen"
    let correctMessage: LocalizedStringKey = "correctMessage"
    let wrong: LocalizedStringKey = "wrong"
    let tryAgain: LocalizedStringKey = "tryAgain"
    let wrongMessage: LocalizedStringKey = "wrongMessage"
    let guessObject: LocalizedStringKey = "guessObject"
    let category: LocalizedStringKey = "category"
    let showAnswer: LocalizedStringKey = "showAnswer"
    let nextQueue: LocalizedStringKey = "nextQueue"
    
    private func showFirstCharacter() {
        guard let item = self.item else { return }
        var new: Character
        new = String(format: NSLocalizedString(item.label, comment: "")).first!
        name.append(new)
        name = name.uppercased()
        correct = String(format: NSLocalizedString(item.label, comment: "")).capitalized + String(format: NSLocalizedString("correct", comment: ""))
    }
    
    private func addCharacter() {
        guard let item = self.item else { return }
        index += 1
        var add: String
        add = String(format: NSLocalizedString(item.label, comment: ""))[index]
        name.append(add)
    }
    
    func showName() {
        guard let item = self.item else { return }
        name = String(format: NSLocalizedString(item.label, comment: ""))
        name = name.capitalized
    }
    
    func guessWord() {
        guard let item = self.item else { return }
        if name.lowercased() == String(format: NSLocalizedString(item.label, comment: "")).lowercased() {
            correctAlert = true
        } else {
            wrongAlert = true
        }
    }
    
    var body: some View {
        VStack {
            // set image view if Library image
            if item?.source == .library, let imageUrl = item?.imageUrl {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 280, height: 280)
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
                    .frame(width: 280, height: 280)
            }
            
            Text(String(format: NSLocalizedString("category", comment: "")) + (item?.category.capitalized ?? "Not Categorized"))
                .font(.system(size: 25))
                .bold()
                .frame(width: 335, height: 50)
            
            TextField("", text: $name)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320)
                .font(.title.bold())
                .padding(.horizontal, 12)
                .disableAutocorrection(true)
            
            HStack(alignment: .center, spacing: 48) {
                Button {
                    addCharacter()
                } label: {
                    GuessButton(action: nextQueue)
                }
                
                Button {
                    showName()
                } label: {
                    GuessButton(action: showAnswer)
                }
            }
            .padding(.top, 8)
        }
        .background(
            Color.white
            .onTapGesture {
                dismissKeyboard()
            }
        )
        .padding(.top, 6)
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            if item?.source == .library {
                showFirstCharacter()
                return
            }
            
            if let image = itemUiImage {
                imagePredictor.userSelectedPhoto(image)
            }
        }
        
        // Construct Item when image is classified
        .onChange(of: imagePredictor.predictionText) { newValue in
            guard item?.source != .library  else { return }
            self.item = Item(
                id: 0,
                label: newValue,
                category: Category.getCategoryName(for: newValue),
                source: .photo
            )
            
            showFirstCharacter()
        }
        .onChange(of: self.name) { newValue in
            if newValue.count == NSLocalizedString(item!.label, comment: "").count {
                guessWord()
            }
            index = name.count - 1
            
        }
        .alert(correct, isPresented: $correctAlert, actions: {
            Button(mainScreen, role: .none) {
                dismissView()
            }
        }, message: {
            Text(correctMessage)
        })
        .alert(wrong, isPresented: $wrongAlert, actions: {
            Button(tryAgain, role: .cancel, action: {
                index = 0
                name = ""
                showFirstCharacter()
            })
        }, message: {
            Text(wrongMessage)
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(guessObject)
                    .fontWeight(.bold)
            }
        }
    }
    
    private func dismissView() {
        item?.source == .library ? navigationRoot.exit() : self.dismiss()
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
    let action: LocalizedStringKey
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.white)
                .border(Color.lightPurple)
                .frame(width: 130, height: 40)
            
            Text(action)
                .bold()
                .foregroundColor(.black)
        }
    }
}
