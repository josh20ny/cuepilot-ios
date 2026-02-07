//
//  ContentView.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \ServicePlan.serviceDate, order: .reverse) private var plans: [ServicePlan]
    @State private var selectedPlanID: UUID?

    private var selectedPlan: ServicePlan? {
        guard let selectedPlanID else { return nil }
        return plans.first(where: { $0.id == selectedPlanID })
    }

    var body: some View {
        NavigationSplitView {
            NavigationStack {
                PlansListView(selectedPlanID: $selectedPlanID)
            }
        } detail: {
            if let selectedPlan {
                NavigationStack {
                    PlanDetailView(plan: selectedPlan)
                }
            } else {
                ContentUnavailableView(
                    "Select a plan",
                    systemImage: "list.bullet.rectangle",
                    description: Text("Create or select a service plan to begin.")
                )
            }
        }
    }
}
