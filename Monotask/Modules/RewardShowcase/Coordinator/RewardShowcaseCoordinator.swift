//
//  RewardShowcaseCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

public final class RewardShowcaseCoordinator {
    func makeView() -> RewardView {
        let taskRepository = makeTaskRepository()
        let rewardRepository = makeRewardRepository()
        let useCase = makeUseCase(rewardRepository: rewardRepository, taskRepository: taskRepository)
        let viewModel = makeViewModel(useCase: useCase)
        let view = RewardView(viewModel: viewModel)
        
        return view
    }
    
    // MARK: - Private
    private func makeViewModel(useCase: RewardListUseCase) -> RewardViewModel {
        return RewardViewModel(useCaseReward: useCase)
    }
    
    private func makeUseCase(rewardRepository: RewardListRepository, taskRepository: TaskListRepository) -> RewardListUseCase {
        return RewardListUseCaseImpl(rewardRepository: rewardRepository, taskRepository: taskRepository)
    }
    
    private func makeRewardRepository() -> RewardListRepository {
        return RewardListRepositoryImpl()
    }
    
    private func makeTaskRepository() -> TaskListRepository {
        return TaskListRepositoryImpl()
    }
}
