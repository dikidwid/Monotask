//
//  AddTaskCoordinatorView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import SwiftUI

struct AddTaskCoordinatorView: View {
    
    @StateObject var coordinator: AddTaskCoordinator
    @Environment(\.dismiss) var dismiss
    let onDismiss: ((TaskModel) -> Void)
    
    var body: some View {
        NavigationStack {
            coordinator.makeAddTaskDetailView(onDismiss: { dismiss() })
                .navigationDestination(isPresented: $coordinator.isShowAddTaskPrioritization) {
                    coordinator.makeAddTaskPrioritizationView(onDismiss: { prepareToDismiss($0) })
                    .navigationBarBackButtonHidden()
                }
        }
        .environmentObject(coordinator)
    }
    
    func prepareToDismiss(_ addedTask: TaskModel) {
        dismiss()
        onDismiss(addedTask)
    }
}

#Preview {
    AddTaskCoordinatorView(coordinator: AddTaskCoordinator(), onDismiss: {_ in })
}
