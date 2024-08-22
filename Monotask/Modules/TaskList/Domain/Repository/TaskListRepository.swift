//
//  TaskListRepository.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

protocol TaskListRepository {
    func fetchTasks() -> [TaskModel]
    func fetchRewards() -> [RewardModel]
    func updateTask(_ updatedTask: TaskModel)
    func updateReward(_ reward: RewardModel)
}
