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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
