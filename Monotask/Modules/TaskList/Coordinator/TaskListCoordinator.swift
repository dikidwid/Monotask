//
//  TaskListCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 17/08/24.
//

import SwiftUI

public final class TaskListCoordinator {

    func makeTaskListView() -> TaskListView {
        let repository = makeTaskListRepository()
        let useCase = makeTaskListUseCase(repository: repository)
        let viewModel = makeTaskListViewModel(useCase: useCase)
        let view = TaskListView(taskListViewModel: viewModel)
        
        return view
    }
    
    // MARK: - Private
    private func makeTaskListViewModel(useCase: TaskListUseCase) -> TaskListViewModel {
        return TaskListViewModel(useCase: useCase)
    }
    
    private func makeTaskListUseCase(repository: TaskListRepository) -> TaskListUseCase {
        return TaskListUseCaseImpl(repository: repository)
    }
    
    private func makeTaskListRepository() -> TaskListRepository {
        return TaskListRepositoryImpl()
    }
}
