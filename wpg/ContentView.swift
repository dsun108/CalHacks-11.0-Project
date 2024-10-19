//
//  ContentView.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

// class geneaiPrompt: ObservableObject{
//     let urlstring: String = "ttps://http://127.0.0.1:5000"
//     func get(){
//         let  Endpoint: String = "how to make a good soup?" //Random query, replace this with text input
//         guard let url = URL(String: urlstring  + EndPoint ) else{/*print an error in chatbox here*/return}
//     }

//     var request = URLREQUEST(url: url)
//     request.httpMethod = "Get"

//     let task = URLSession.shared.dataTask(with:request) {data,response, error in if let error = error{return}}

//     }

struct ContentView: View {
    var body: some View {
        TabView{
            
        }
        
        VStack {
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
