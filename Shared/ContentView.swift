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
    
    //Alert inits
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
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
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            })
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
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already!", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized!", message: "You can't just make up a word!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "This isn't a real word!")
            return
        }
        
        
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
    
    //Word hasnt been used
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    //Word is possible to use using input
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                //Not possible
                return false
            }
        }
        //All good
        return true
    }
    
    //Word is a real word
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        //??
        return misspelledRange.location == NSNotFound
    }
    
    //Show message to title and message
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
