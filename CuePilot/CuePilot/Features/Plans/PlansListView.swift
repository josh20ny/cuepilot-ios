//
//  PlansListView.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import SwiftUI
import SwiftData

struct PlansListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ServicePlan.serviceDate, order: .reverse) private var plans: [ServicePlan]

    @Binding var selectedPlanID: UUID?

    var body: some View {
        List(selection: $selectedPlanID) {
            ForEach(plans) { plan in
                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.title).font(.headline)
                    Text("\(plan.serviceDate.formatted(date: .abbreviated, time: .omitted)) • \(plan.serviceTime.formatted(date: .omitted, time: .shortened))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .tag(plan.id as UUID?)
            }
            .onDelete(perform: deletePlans)
        }
        .navigationTitle("CuePilot")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    createPlan()
                } label: {
                    Label("New Plan", systemImage: "plus")
                }
            }
        }
    }

    private func createPlan() {
        let now = Date()
        let newPlan = ServicePlan(
            title: "New Service Plan",
            serviceDate: now,
            serviceTime: now,
            status: .draft
        )
        modelContext.insert(newPlan)
        selectedPlanID = newPlan.id
    }

    private func deletePlans(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(plans[index])
        }

        if let selectedPlanID, !plans.contains(where: { $0.id == selectedPlanID }) {
            self.selectedPlanID = nil
        }
    }
}
