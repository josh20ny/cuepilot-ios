//
//  LiveEvent.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation
import SwiftData

@Model
final class LiveEvent {
    @Attribute(.unique) var id: UUID
    var eventTypeRaw: String
    var value: String?
    var timestamp: Date

    var plan: ServicePlan?
    var item: PlanItem?

    init(
        id: UUID = UUID(),
        eventType: LiveEventType,
        value: String? = nil,
        timestamp: Date = Date(),
        plan: ServicePlan? = nil,
        item: PlanItem? = nil
    ) {
        self.id = id
        self.eventTypeRaw = eventType.rawValue
        self.value = value
        self.timestamp = timestamp
        self.plan = plan
        self.item = item
    }

    var eventType: LiveEventType {
        get { LiveEventType(rawValue: eventTypeRaw) ?? .note }
        set { eventTypeRaw = newValue.rawValue }
    }
}
