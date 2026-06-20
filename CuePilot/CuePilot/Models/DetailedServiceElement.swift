//
//  DetailedServiceElement.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/20/26.
//

import Foundation

struct DetailedServiceElement: Sendable, Identifiable {
    let id = UUID()

    let timeOffset: TimeInterval?
    let description: String
    let tag: Tag
    let notes: String?
}
