//
//  Duration+Extensions.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/26/26.
//

import Foundation

extension Duration {
    var formattedTime: String {
        let totalSeconds = max(0, Int(components.seconds))
        let h = totalSeconds / 3600
        let m = (totalSeconds % 3600) / 60
        let s = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}
