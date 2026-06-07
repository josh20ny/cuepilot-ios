//
//  PlanningCenterItemView.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/24/26.
//

import SwiftUI

struct ServiceElementRow: View {
    let element: ServiceElement
    private let formatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "hh:mm:ssa"
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: .space24) {
            Text(formatter.string(from: element.startTime))
                .font(.customFont(.bodyMonospace))
            
            Text(element.duration.formattedTime)
                .font(.customFont(.bodyMonospace))
            
            Text(element.description)
                .font(.customFont(.bodyBold))
        }
    }
}

#Preview {
    ServiceElementRow(element: ServiceElement(
        startTime: Date(),
        duration: .seconds(180),
        description: "Hosting")
    )
}
