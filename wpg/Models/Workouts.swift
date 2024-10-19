//
//  Workouts.swift
//  wpg
//
//  Created by David Sun on 10/19/24.
//

import Foundation

struct Workouts: Codable {
    let name, type, muscle, equipment: String
    let difficulty, instructions: String
}
