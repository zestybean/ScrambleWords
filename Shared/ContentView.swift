//
//  ContentView.swift
//  Shared
//
//  Created by Brando Lugo on 1/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Text("Blah")
                }
                
                Section{
                    Text("Blah")
                }
                
                Section{
                    Text("Blah")
                }
                
            }
            .navigationTitle("Blah")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
