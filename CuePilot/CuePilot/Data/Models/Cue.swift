//
//  Cue.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation
import SwiftData

@Model
final class Cue {
    @Attribute(.unique) var id: UUID
    var roleRaw: String
    var triggerTypeRaw: String
    var offsetSec: Int?
    var absoluteTime: Date?
    var priorityRaw: String
    var callText: String
    var checklistFlag: Bool
    var sortOrder: Int

    var plan: ServicePlan?
    var item: PlanItem?

    init(
        id: UUID = UUID(),
        role: Role = .producer,
        triggerType: TriggerType = .manual,
        offsetSec: Int? = nil,
        absoluteTime: Date? = nil,
        priority: CuePriority = .normal,
        callText: String,
        checklistFlag: Bool = false,
        sortOrder: Int = 0,
        plan: ServicePlan? = nil,
        item: PlanItem? = nil
    ) {
        self.id = id
        self.roleRaw = role.rawValue
        self.triggerTypeRaw = triggerType.rawValue
        self.offsetSec = offsetSec
        self.absoluteTime = absoluteTime
        self.priorityRaw = priority.rawValue
        self.callText = callText
        self.checklistFlag = checklistFlag
        self.sortOrder = sortOrder
        self.plan = plan
        self.item = item
    }

    var role: Role {
        get { Role(rawValue: roleRaw) ?? .producer }
        set { roleRaw = newValue.rawValue }
    }

    var triggerType: TriggerType {
        get { TriggerType(rawValue: triggerTypeRaw) ?? .manual }
        set { triggerTypeRaw = newValue.rawValue }
    }

    var priority: CuePriority {
        get { CuePriority(rawValue: priorityRaw) ?? .normal }
        set { priorityRaw = newValue.rawValue }
    }
}
