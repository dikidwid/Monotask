//
//  AddTaskCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import SwiftUI

public final class AddTaskCoordinator: ObservableObject {
    
    @Published var isShowAddTaskPrioritization: Bool = false
    @Published var addTaskViewModel: AddTaskViewModel
    
    init() {
        let repository = AddTaskRepositoryImpl()
        let useCase = AddTaskUseCaseImpl(repository: repository)
        let viewModel = AddTaskViewModel(useCase: useCase)
        
        self.addTaskViewModel = viewModel
    }
    
    func makeAddTaskDetailView(onDismiss: @escaping (() -> Void)) -> AddTaskDetailView {
        AddTaskDetailView(addTaskViewModel: self.addTaskViewModel, onDismiss: onDismiss)
    }
    
    func makeAddTaskPrioritizationView(onDismiss: @escaping (() -> Void)) -> AddTaskPrioritizationView {
        AddTaskPrioritizationView(addTaskViewModel: self.addTaskViewModel, onDismiss: onDismiss)
    }
}
