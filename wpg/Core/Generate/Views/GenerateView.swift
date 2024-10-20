//
//  SwiftUIView.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import SwiftUI

struct GenerateView: View {
    struct Message: Encodable {
        let goals: String
        let experience: String
        let days: String
    }
    var goals = ["Get Into Shape", "Bodybuilding", "Powerlifting"]
    var experiences = ["Beginner", "Intermediate", "Advanced"]
    var days = ["1", "2", "3", "4", "5", "6", "7"]
    
    @State private var selectedGoal: String = "Get Into Shape"
    @State private var selectedExperience: String = "Beginner"
    @State private var selectedDays: String = "1"
    
    @EnvironmentObject var network: Network
    var body: some View {
        VStack {
            Menu(selectedGoal) {
                ForEach(goals, id: \.self) { goal in
                    Button(goal, action: {
                        selectedGoal = goal
                    })
                }
            }
            Menu(selectedExperience) {
                ForEach(experiences, id: \.self) { experience in
                    Button(experience, action: {
                        selectedExperience = experience
                    })
                }
            }
            Menu(selectedDays) {
                ForEach(days, id: \.self) { day in
                    Button(day, action: {
                        selectedDays = day
                    })
                }
            }
            Button(action: {
                //Get Email and Password
                network.sendData(goal:selectedGoal, exp:selectedExperience, days:selectedDays)
                
            }) {
                Text("Submit")
                }
        }
        .environmentObject(Network())
    }
}

#Preview {
    GenerateView()
}
