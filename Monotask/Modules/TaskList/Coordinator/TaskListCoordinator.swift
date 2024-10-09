//
//  TaskListCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 17/08/24.
//

import SwiftUI

public final class TaskListCoordinator {

    func makeTaskListView() -> TaskListView {
        let taskListRepository = makeTaskListRepository()
        let rewardListRepository = makeRewardListRepository()
        let useCase = makeTaskListUseCase(taskListRepository: taskListRepository, rewardListRepository: rewardListRepository)
        let viewModel = makeTaskListViewModel(useCase: useCase)
        let view = TaskListView(taskListViewModel: viewModel)
        
        return view
    }
    
    // MARK: - Private
    private func makeTaskListViewModel(useCase: TaskListUseCase) -> TaskListViewModel {
        return TaskListViewModel(useCase: useCase)
    }
    
    private func makeTaskListUseCase(taskListRepository: TaskListRepository, rewardListRepository: RewardListRepository) -> TaskListUseCase {
        return TaskListUseCaseImpl(repository: taskListRepository, rewardListRepository: rewardListRepository)
    }
    
    private func makeTaskListRepository() -> TaskListRepository {
        return TaskListRepositoryImpl()
    }
    
    private func makeRewardListRepository() -> RewardListRepository {
        return RewardListRepositoryImpl()
    }
}
