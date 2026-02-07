//
//  CuePilotApp.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import SwiftUI
import SwiftData

@main
struct CuePilotApp: App {
    private let container = ModelContainerFactory.make()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
