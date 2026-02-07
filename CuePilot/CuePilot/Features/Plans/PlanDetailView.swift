//
//  PlanDetailView.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/6/26.
//

import SwiftUI
import SwiftData

struct PlanDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var plan: ServicePlan

    @State private var showingAddItem = false
    @State private var showingAddGlobalCue = false


    private var sortedItems: [PlanItem] {
        plan.items
            .filter { $0.isActive }
            .sorted { $0.orderIndex < $1.orderIndex }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(plan.title).font(.title2).bold()
                    Text("\(plan.serviceDate.formatted(date: .long, time: .omitted)) • \(plan.serviceTime.formatted(date: .omitted, time: .shortened))")
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Picker("Status", selection: Binding(
                    get: { plan.status },
                    set: { plan.status = $0 }
                )) {
                    ForEach(PlanStatus.allCases) { status in
                        Text(status.rawValue.capitalized).tag(status)
                    }
                }
                .pickerStyle(.menu)
            }

            Divider()

            List {
                ForEach(sortedItems) { item in
                    NavigationLink {
                        PlanItemEditorView(item: item)
                    } label: {
                        PlanItemRow(item: item)
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }

            .listStyle(.inset)
        }
        .padding()
        .navigationTitle("Plan")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddItem = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddGlobalCue = true
                } label: {
                    Label("Global Cue", systemImage: "bolt")
                }
            }
        }

        .sheet(isPresented: $showingAddItem) {
            AddPlanItemSheet(plan: plan)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showingAddGlobalCue) {
            CueEditorView(plan: plan, item: nil, existingCue: nil)
                .presentationDetents([.large])
        }

    }

    private func deleteItems(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { sortedItems[$0] }
        for item in itemsToDelete {
            modelContext.delete(item)
        }
        normalizeOrderIndexes()
    }

    private func normalizeOrderIndexes() {
        let updated = sortedItems
        for (index, item) in updated.enumerated() {
            item.orderIndex = index
        }
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        var updated = sortedItems
        updated.move(fromOffsets: source, toOffset: destination)

        for (index, item) in updated.enumerated() {
            item.orderIndex = index
        }
    }
}
