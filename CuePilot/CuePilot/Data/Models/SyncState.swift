//
//  SyncState.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation
import SwiftData

@Model
final class SyncState {
    @Attribute(.unique) var id: UUID
    var source: String
    var syncToken: String?
    var lastSyncAt: Date?

    var plan: ServicePlan?

    init(
        id: UUID = UUID(),
        source: String = "planning_center",
        syncToken: String? = nil,
        lastSyncAt: Date? = nil,
        plan: ServicePlan? = nil
    ) {
        self.id = id
        self.source = source
        self.syncToken = syncToken
        self.lastSyncAt = lastSyncAt
        self.plan = plan
    }
}
