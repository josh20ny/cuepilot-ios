//
//  PlanItemEditorView.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import SwiftUI
import SwiftData

struct PlanItemEditorView: View {
    @Bindable var item: PlanItem
    @State private var durationMinutes: Int = 3
    @State private var showingAddCue = false
    @State private var showingCues = true
    @State private var showingEditCue = false
    @State private var selectedCue: Cue?


    var body: some View {
        Form {
            Section("Details") {
                TextField("Title", text: Binding(
                    get: { item.title },
                    set: { item.title = $0 }
                ))

                Picker("Type", selection: Binding(
                    get: { item.itemType },
                    set: { item.itemType = $0 }
                )) {
                    ForEach(PlanItemType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
            }

            Section("Duration") {
                Stepper("Minutes: \(durationMinutes)", value: $durationMinutes, in: 1...180)
                    .onChange(of: durationMinutes) { _, newValue in
                        item.plannedDurationSec = newValue * 60
                    }
            }
            
            Section {
                DisclosureGroup("Cues", isExpanded: $showingCues) {
                    if item.cues.isEmpty {
                        Text("No cues yet.")
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 4)
                    } else {
                        ForEach(item.cues.sorted(by: { $0.sortOrder < $1.sortOrder })) { cue in
                            Button {
                                selectedCue = cue
                                showingEditCue = true
                            } label: {
                                CueRow(cue: cue)
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: deleteCues)
                    }

                    Button {
                        showingAddCue = true
                    } label: {
                        Label("Add Cue", systemImage: "plus")
                    }
                    .padding(.top, 6)
                }
            } header: {
                Text("Cues")
            }


            Section("Notes") {
                TextEditor(text: Binding(
                    get: { item.notes ?? "" },
                    set: { item.notes = $0.isEmpty ? nil : $0 }
                ))
                .frame(minHeight: 140)
            }
        }
        .navigationTitle("Edit Item")
        .onAppear {
            durationMinutes = max(1, item.plannedDurationSec / 60)
        }
        
        .sheet(isPresented: $showingAddCue) {
            if let plan = item.plan {
                CueEditorView(plan: plan, item: item, existingCue: nil)
                    .presentationDetents([.large])
            } else {
                Text("Missing plan reference.")
                    .padding()
            }
        }
        .sheet(isPresented: $showingEditCue) {
            if let plan = item.plan, let cue = selectedCue {
                CueEditorView(plan: plan, item: item, existingCue: cue)
                    .presentationDetents([.large])
            } else {
                Text("Missing cue reference.")
                    .padding()
            }
        }


    }
    @Environment(\.modelContext) private var modelContext

    private func deleteCues(at offsets: IndexSet) {
        let sorted = item.cues.sorted(by: { $0.sortOrder < $1.sortOrder })
        for index in offsets {
            modelContext.delete(sorted[index])
        }
    }

}
