//
//  ServicePlan.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation
import SwiftData

@Model
final class ServicePlan {
    @Attribute(.unique) var id: UUID
    var externalPlanId: String?
    var title: String
    var serviceDate: Date
    var serviceTime: Date
    var statusRaw: String
    var lastSyncedAt: Date?
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \PlanItem.plan)
    var items: [PlanItem] = []

    @Relationship(deleteRule: .cascade, inverse: \Cue.plan)
    var cues: [Cue] = []

    @Relationship(deleteRule: .cascade, inverse: \ChecklistItem.plan)
    var checklistItems: [ChecklistItem] = []

    @Relationship(deleteRule: .cascade, inverse: \LiveEvent.plan)
    var liveEvents: [LiveEvent] = []

    @Relationship(deleteRule: .cascade, inverse: \SyncState.plan)
    var syncStates: [SyncState] = []

    init(
        id: UUID = UUID(),
        externalPlanId: String? = nil,
        title: String,
        serviceDate: Date,
        serviceTime: Date,
        status: PlanStatus = .draft,
        lastSyncedAt: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.externalPlanId = externalPlanId
        self.title = title
        self.serviceDate = serviceDate
        self.serviceTime = serviceTime
        self.statusRaw = status.rawValue
        self.lastSyncedAt = lastSyncedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var status: PlanStatus {
        get { PlanStatus(rawValue: statusRaw) ?? .draft }
        set { statusRaw = newValue.rawValue }
    }
}
