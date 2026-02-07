//
//  Enums.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import Foundation

enum PlanStatus: String, Codable, CaseIterable, Identifiable {
    case draft, ready, live, completed
    var id: String { rawValue }
}

enum PlanItemType: String, Codable, CaseIterable, Identifiable {
    case song, host, video, message, bumper, giving, other
    var id: String { rawValue }
}

enum Role: String, Codable, CaseIterable, Identifiable {
    case producer, host, audio, video, lights, band, camera, other
    var id: String { rawValue }
}

enum TriggerType: String, Codable, CaseIterable, Identifiable {
    case relativeStart, relativeEnd, absoluteClock, manual
    var id: String { rawValue }
}

enum CuePriority: String, Codable, CaseIterable, Identifiable {
    case normal, high, critical
    var id: String { rawValue }
}

enum LiveEventType: String, Codable, CaseIterable, Identifiable {
    case startService, completeItem, hold, skip, manualCue, note
    var id: String { rawValue }
}

