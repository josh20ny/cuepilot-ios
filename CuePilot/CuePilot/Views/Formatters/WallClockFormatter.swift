//
//  WallClockFormatter.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/20/26.
//

import Foundation

struct WallClockFormatter {
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }()

    func string(from date: Date) -> String {
        return formatter.string(from: date)
    }
}
