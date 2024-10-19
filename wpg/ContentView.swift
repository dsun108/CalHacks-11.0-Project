//
//  ContentView.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

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
