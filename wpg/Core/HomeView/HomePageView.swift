//
//  HomePage.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

struct HomePageView: View {
    @State private var selectedTab: Int = 0
    @EnvironmentObject var network: Network
    
    var body: some View {
        TabView{
            GenerateView()
                .tabItem {
                    VStack {
                        Image(systemName: "figure.run")
                            .environment(\.symbolVariants,selectedTab == 0 ? .fill : .none)
                        Text("Generate")
                    }
                }
                .onAppear{
                    selectedTab = 0
                    network.getUsers()
                }
            CalendarView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                            .environment(\.symbolVariants,selectedTab == 1 ? .fill : .none)
                        Text("Calendar")
                    }
                }
                .onAppear{
                    selectedTab = 1
                }
            WorkoutsView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .environment(\.symbolVariants,selectedTab == 2 ? .fill : .none)
                        Text("Workouts")
                    }
                }
                .onAppear{
                    selectedTab = 2
                }
            MoreView()
                .tabItem {
                    VStack {
                        Image(systemName: "ellipsis")
                            .environment(\.symbolVariants,selectedTab == 3 ? .fill : .none)
                        Text("More")
                    }
                }
                .onAppear{
                    selectedTab = 3
                }
        }
        .environmentObject(Network())

    }
}

#Preview {
    HomePageView()
}
