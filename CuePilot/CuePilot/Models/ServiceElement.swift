//
//  PlanningCenterItem.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/24/26.
//

import Foundation

struct ServiceElement: Decodable, Sendable {
    let startTime: Date
    let duration: Duration
    let description: String
}
