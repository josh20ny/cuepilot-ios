//
//  TimeIntervalFormatter.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/20/26.
//

import Foundation

struct TimeIntervalFormatter {
    func string(from interval: TimeInterval) -> String {
        let absoluteInterval = abs(interval)
        let hours = Int(absoluteInterval) / 3600
        let minutes = (Int(absoluteInterval) % 3600) / 60
        let seconds = Int(absoluteInterval) % 60

        return interval < 0 ?
            String(format: "-%02d:%02d:%02d", hours, minutes, seconds) :
            String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
