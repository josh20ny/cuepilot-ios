//
//  ChecklistItem.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation
import SwiftData

enum ChecklistPhase: String, Codable, CaseIterable, Identifiable {
    case preservice, countdown, betweenServices, postservice
    var id: String { rawValue }
}

@Model
final class ChecklistItem {
    @Attribute(.unique) var id: UUID
    var phaseRaw: String
    var title: String
    var isCompleted: Bool
    var completedAt: Date?

    var plan: ServicePlan?

    init(
        id: UUID = UUID(),
        phase: ChecklistPhase,
        title: String,
        isCompleted: Bool = false,
        completedAt: Date? = nil,
        plan: ServicePlan? = nil
    ) {
        self.id = id
        self.phaseRaw = phase.rawValue
        self.title = title
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.plan = plan
    }

    var phase: ChecklistPhase {
        get { ChecklistPhase(rawValue: phaseRaw) ?? .preservice }
        set { phaseRaw = newValue.rawValue }
    }
}
