//
//  HomePage.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        TabView{
            Text("Plan").tabItem {
                VStack{
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Plan")
                }
            }
            Text("Plan").tabItem {
                VStack{
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Plan")
                }
            }

        }
        
    }
}

#Preview {
    HomePageView()
}
