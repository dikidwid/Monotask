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
    let onDismiss: (() -> Void)
    
    var body: some View {
        NavigationStack {
            coordinator.makeAddTaskDetailView(onDismiss: { prepareToDismiss() })
                .navigationDestination(isPresented: $coordinator.isShowAddTaskPrioritization) {
                    coordinator.makeAddTaskPrioritizationView(onDismiss: { prepareToDismiss() })
                    .navigationBarBackButtonHidden()
                }
        }
        .environmentObject(coordinator)
    }
    
    func prepareToDismiss() {
        dismiss()
        onDismiss()
    }
}

#Preview {
    AddTaskCoordinatorView(coordinator: AddTaskCoordinator(), onDismiss: {})
}
