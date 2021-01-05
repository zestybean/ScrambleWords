//
//  ContentView.swift
//  Shared
//
//  Created by Brando Lugo on 1/3/21.
//

import SwiftUI

struct ContentView: View {
    //Inits
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(usedWords, id: \.self){
                    Text($0)
                    Spacer()
                    Image(systemName: "\($0.count).circle")
                }
            }
            .navigationTitle(rootWord)
        }
    }
    
    func addNewWord() {
        //Lowercase and trim the word to make sure we dont duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Exit if empty
        guard answer.count > 0 else {
            return
        }
        
        //Extra validation here
        
        //Insert to the beginning of the list
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        //1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                //3. Split the string up into an array of string, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                //4. Pick a random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkWorm"
                
                //Everything worked!
                return
            }
        }
        
        //If we are here we royaly messed up
        fatalError("Failed to start game: Look for start.txt in bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
