//
//  WorkoutsView.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

struct WorkoutsView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Text("Searching for \(searchText)")
                .navigationTitle("Searchable Example")
        }
        .searchable(text: $searchText, prompt: "Look for a workout")
    }
}

#Preview {
    WorkoutsView()
}
