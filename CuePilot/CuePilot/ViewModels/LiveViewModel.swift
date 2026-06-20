//
//  MockViewModel.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/20/26.
//

import Foundation

@MainActor @Observable
class LiveViewModel {
    let currentTime: Date = Date()
    let timeInCurrentCue: TimeInterval = 74
    let serviceEndOffset: TimeInterval = -127
    let isLive: Bool = true


    // TODO: This is just mock data for now
    let plan: [DetailedServiceElement] = [
        DetailedServiceElement(
            timeOffset: -300,
            description: "Confirm everyone is on headset",
            tag: .producerAction,
            notes: nil
        ),

        DetailedServiceElement(
            timeOffset: nil,
            description: "Silence cell phones",
            tag: .productionComms,
            notes: "Especially Josh"
        ),

        DetailedServiceElement(
            timeOffset: nil,
            description: "Start recording video",
            tag: .productionComms,
            notes: nil
        ),

        DetailedServiceElement(
            timeOffset: -180,
            description: "3 minute warning",
            tag: .bandInEars,
            notes: nil
        ),

        DetailedServiceElement(
            timeOffset: nil,
            description: "Get band back stage",
            tag: .productionComms,
            notes: nil
        ),
    ]
}
