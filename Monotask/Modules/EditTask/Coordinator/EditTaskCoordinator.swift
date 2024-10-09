//
//  EditTaskCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import Foundation

public final class EditTaskCoordinator {

    func makeEditTaskDetailView(taskID: String, onDismiss: @escaping ((TaskModel) -> Void)) -> EditTaskDetailView {
        let repository = makeRepository()
        let useCase = makeUseCase(repository: repository)
        let viewModel = makeViewModel(taskID: taskID, useCase: useCase)
        let view = EditTaskDetailView(editTaskViewModel: viewModel, onDismiss: onDismiss)
        
        return view
    }
    
    // MARK: - Private
    private func makeViewModel(taskID: String, useCase: EditTaskUseCase) -> EditTaskViewModel {
        return EditTaskViewModel(taskID: taskID, useCase: useCase)
    }
    
    private func makeUseCase(repository: EditTaskRepository) -> EditTaskUseCase {
        return EditTaskUseCaseImpl(repository: repository)
    }
    
    private func makeRepository() -> EditTaskRepository {
        return EditTaskRepositoryImpl()
    }
}
