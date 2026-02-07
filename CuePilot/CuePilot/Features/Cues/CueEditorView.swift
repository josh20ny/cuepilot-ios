//
//  CueEditorView.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import SwiftUI
import SwiftData

struct CueEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let plan: ServicePlan
    let item: PlanItem?
    let existingCue: Cue?

    @State private var role: Role = .producer
    @State private var triggerType: TriggerType = .manual
    @State private var offsetSeconds: Int = 0
    @State private var priority: CuePriority = .normal
    @State private var callText: String = ""
    @State private var checklistFlag: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Cue") {
                    Picker("Role", selection: $role) {
                        ForEach(Role.allCases) { r in
                            Text(r.rawValue.capitalized).tag(r)
                        }
                    }

                    Picker("Trigger", selection: $triggerType) {
                        Text("Manual").tag(TriggerType.manual)
                        Text("Relative to Start").tag(TriggerType.relativeStart)
                        Text("Relative to End").tag(TriggerType.relativeEnd)
                        Text("Absolute Clock").tag(TriggerType.absoluteClock)
                    }

                    if triggerType == .relativeStart || triggerType == .relativeEnd {
                        Stepper("Offset: \(offsetSeconds)s", value: $offsetSeconds, in: -600...600, step: 5)
                        Text("Tip: negative = before, positive = after")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } else if triggerType == .absoluteClock {
                        Text("Absolute clock support comes in Part 2 (we’ll wire the picker).")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Picker("Priority", selection: $priority) {
                        ForEach(CuePriority.allCases) { p in
                            Text(p.rawValue.capitalized).tag(p)
                        }
                    }

                    Toggle("Checklist item", isOn: $checklistFlag)

                    TextField("Call text (ex: “Standby host… GO”)",
                              text: $callText,
                              axis: .vertical)
                    .lineLimit(3...8)
                }

                Section("Quick Presets") {
                    presetButton("3:00 warning")
                    presetButton("30 sec warning")
                    presetButton("Standby…")
                    presetButton("GO")
                    presetButton("Send Host")
                    presetButton("Fire Video")
                }
            }
            .navigationTitle(existingCue == nil ? "Add Cue" : "Edit Cue")

            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveCue() }
                        .disabled(callText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                if let cue = existingCue {
                    role = cue.role
                    triggerType = cue.triggerType
                    offsetSeconds = cue.offsetSec ?? 0
                    priority = cue.priority
                    callText = cue.callText
                    checklistFlag = cue.checklistFlag
                }
            }
        }
    }

    private func presetButton(_ text: String) -> some View {
        Button(text) {
            if callText.isEmpty {
                callText = text
            } else {
                callText += "\n" + text
            }
        }
    }

    private func saveCue() {
        let trimmed = callText.trimmingCharacters(in: .whitespacesAndNewlines)

        if let cue = existingCue {
            cue.role = role
            cue.triggerType = triggerType
            cue.offsetSec = (triggerType == .relativeStart || triggerType == .relativeEnd) ? offsetSeconds : nil
            cue.absoluteTime = nil
            cue.priority = priority
            cue.callText = trimmed
            cue.checklistFlag = checklistFlag
            dismiss()
            return
        }

        let nextSort = (plan.cues.map { $0.sortOrder }.max() ?? -1) + 1

        let cue = Cue(
            role: role,
            triggerType: triggerType,
            offsetSec: (triggerType == .relativeStart || triggerType == .relativeEnd) ? offsetSeconds : nil,
            absoluteTime: nil,
            priority: priority,
            callText: trimmed,
            checklistFlag: checklistFlag,
            sortOrder: nextSort,
            plan: plan,
            item: item
        )

        modelContext.insert(cue)
        plan.cues.append(cue)
        if let item { item.cues.append(cue) }

        dismiss()
    }

}
