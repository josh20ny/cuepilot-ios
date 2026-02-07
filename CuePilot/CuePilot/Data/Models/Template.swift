//
//  Template.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import Foundation
import SwiftData

@Model
final class Template {
    @Attribute(.unique) var id: UUID
    var name: String
    var planStructureJson: String
    var cueLibraryJson: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        planStructureJson: String = "{}",
        cueLibraryJson: String = "{}",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.planStructureJson = planStructureJson
        self.cueLibraryJson = cueLibraryJson
        self.createdAt = createdAt
    }
}
