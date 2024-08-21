//
//  RewardListUseCase.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

protocol RewardListUseCase: GetTasksUseCase {
    func getRewards() -> [RewardModel]
    func updateReward(_ updatedReward: RewardModel)
}

struct RewardListUseCaseImpl: RewardListUseCase {
    let rewardRepository: RewardListRepository
    let taskRepository: TaskListRepository
    
    func getRewards() -> [RewardModel] {
        rewardRepository.fetchRewards()
    }
    
    func getTasks() -> [TaskModel] {
        taskRepository.fetchTasks()
    }
    
    func updateReward(_ updatedReward: RewardModel) {
        rewardRepository.updateReward(updatedReward)
    }
}
