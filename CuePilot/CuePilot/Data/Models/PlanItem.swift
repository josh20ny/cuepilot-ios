//
//  PlanItem.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation
import SwiftData

@Model
final class PlanItem {
    @Attribute(.unique) var id: UUID
    var externalItemId: String?
    var orderIndex: Int
    var title: String
    var itemTypeRaw: String
    var plannedStart: Date?
    var plannedDurationSec: Int
    var notes: String?
    var isActive: Bool

    var plan: ServicePlan?

    @Relationship(deleteRule: .cascade, inverse: \Cue.item)
    var cues: [Cue] = []

    init(
        id: UUID = UUID(),
        externalItemId: String? = nil,
        orderIndex: Int,
        title: String,
        itemType: PlanItemType = .other,
        plannedStart: Date? = nil,
        plannedDurationSec: Int,
        notes: String? = nil,
        isActive: Bool = true,
        plan: ServicePlan? = nil
    ) {
        self.id = id
        self.externalItemId = externalItemId
        self.orderIndex = orderIndex
        self.title = title
        self.itemTypeRaw = itemType.rawValue
        self.plannedStart = plannedStart
        self.plannedDurationSec = plannedDurationSec
        self.notes = notes
        self.isActive = isActive
        self.plan = plan
    }

    var itemType: PlanItemType {
        get { PlanItemType(rawValue: itemTypeRaw) ?? .other }
        set { itemTypeRaw = newValue.rawValue }
    }
}
