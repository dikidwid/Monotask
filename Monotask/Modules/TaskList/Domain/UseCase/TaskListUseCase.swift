//
//  TaskListUseCase.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

protocol TaskListUseCase {
    func getTasks() -> [TaskModel]
    func updateTaskStatus(_ updatedTask: TaskModel)
    func getRewards() -> [RewardModel]
    func updateReward(_ updatedReward: RewardModel)
}

struct TaskListUseCaseImpl: TaskListUseCase {
    let repository: TaskListRepository
    let rewardListRepository: RewardListRepository
    
    func getTasks() -> [TaskModel] {
        let tasks = repository.fetchTasks()
        let sortedTasksByMatrixParamaters: [TaskModel] = tasks.sorted { task1, task2 in
            if task1.urgencyMetric != task2.urgencyMetric {
                return task1.urgencyMetric > task2.urgencyMetric
            } else if task1.difficultyMetric != task2.difficultyMetric {
                return task1.difficultyMetric < task2.difficultyMetric
            } else {
                return task1.interestMetric > task2.interestMetric
            }
        }
        
        return sortedTasksByMatrixParamaters
    }
    
    func updateTaskStatus(_ updatedTask: TaskModel) {
        repository.updateTask(updatedTask)
    }
    
    func getRewards() -> [RewardModel] {
        rewardListRepository.fetchRewards()
    }
    
    func updateReward(_ updatedReward: RewardModel) {
        rewardListRepository.updateReward(updatedReward)
    }
}
