//
//  ModelContainerFactory.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import Foundation
import SwiftData

enum ModelContainerFactory {
    static func make() -> ModelContainer {
        do {
            let schema = Schema([
                ServicePlan.self,
                PlanItem.self,
                Cue.self,
                ChecklistItem.self,
                LiveEvent.self,
                Template.self,
                SyncState.self
            ])

            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
