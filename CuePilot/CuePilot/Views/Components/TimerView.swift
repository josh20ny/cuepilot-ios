//
//  TimerView.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/22/26.
//

import SwiftUI

struct TimerView: View {
    @ScaledMetric private var scale: CGFloat = 1.0
    
    enum TimeDisplay {
        case wallClock(Date)
        case timer(TimeInterval)
    }
    
    private var formattedTime: String {
        switch time {
        case .wallClock(let date):
            let formatter = DateFormatter()
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "hh:mm:ss a"
            return formatter.string(from: date)
            
        case .timer(let interval):
            let hours = Int(interval) / 3600
            let minutes = (Int(interval) % 3600) / 60
            let seconds = Int(interval) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
    let label: String
    let time: TimeDisplay
    
    init(label: String, time: TimeDisplay) {
        self.label = label
        self.time = time
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(label)
                .appFont(.body)
                .foregroundStyle(Color.foregroundPrimary)
                .padding(.bottom, .space4)
            
            Divider()
                .frame(width: 150.0 * scale, height: 1)
                .background(Color.foregroundPrimary)
                .padding(.bottom, .space8)
            
            Text(formattedTime)
                .foregroundStyle(Color.foregroundPrimary)
                .appFont(.h3Monospace)
                .monospacedDigit()
        }
    }
}

#Preview("wall clock") {
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()
        
        TimerView(
            label: "Time",
            time: .wallClock(Date())
        )
    }
}

#Preview("timer") {
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()
        
        TimerView(
            label: "Time in Current",
            time: .timer(535)
        )
    }
}
