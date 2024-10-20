//
//  wpgApp.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

@main
struct wpgApp: App {
    var network = Network()
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environmentObject(network)
        }
    }
}
