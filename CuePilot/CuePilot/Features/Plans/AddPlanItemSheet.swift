//
//  AddPlanItemSheet.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import SwiftUI
import SwiftData

struct AddPlanItemSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let plan: ServicePlan

    @State private var title: String = ""
    @State private var itemType: PlanItemType = .other
    @State private var durationMinutes: Int = 3

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Title", text: $title)
                    Picker("Type", selection: $itemType) {
                        ForEach(PlanItemType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    Stepper("Duration: \(durationMinutes) min", value: $durationMinutes, in: 1...60)
                }
            }
            .navigationTitle("Add Plan Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { addItem() }
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func addItem() {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let nextIndex = (plan.items.map { $0.orderIndex }.max() ?? -1) + 1

        let item = PlanItem(
            orderIndex: nextIndex,
            title: trimmed,
            itemType: itemType,
            plannedDurationSec: durationMinutes * 60,
            plan: plan
        )

        modelContext.insert(item)
        plan.items.append(item)

        dismiss()
    }
}
