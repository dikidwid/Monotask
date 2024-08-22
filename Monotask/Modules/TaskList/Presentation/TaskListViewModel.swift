//
//  TaskListViewModel.swift
//  MC3
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import Foundation
import SwiftUI

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    @Published var currentTask: TaskModel?
    @Published var hasNewJourneyPiece: Bool = false
    @Published var isShowRemoveCheckmarkAlert: Bool =  false
    
    let useCase: TaskListUseCase
    let audioManager: AudioManager = AudioManager.shared
    
    let whiteOverlay: [Color] = [.white.opacity(0.7),
                                   .clear,
                                   .clear,
                                   .clear,
                                   .white.opacity(0.7)]
    
    var totalTasks: Int {
        tasks.count
    }
    
    var totalCompletedTasks: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    
    init(useCase: TaskListUseCase) {
        self.useCase = useCase
    }
    
    func onAppearAction() {
        let rewards = useCase.getRewards()
        getTasks()
        currentTask = tasks.first
        print("on appear in tasklist: \(rewards[0].rewardName) is \(rewards[0].isUnlockedTap)")
    }
    
    func getTasks() {
       tasks = useCase.getTasks()
    }
    
    func resetUnlockedRewardsIfNeeded() {
        let rewards = useCase.getRewards()
        
        for index in rewards.indices {
            var reward = rewards[index]
            if totalCompletedTasks < reward.minimumTask {
                reward.isUnlockedTap = false
                useCase.updateReward(reward)
                print("isUnlockedTap status of in tasklist : \(reward.rewardName) is \(reward.isUnlockedTap)")
                print("Reset reward in tasklist: \(reward.rewardName) to locked")
            }
        }
    }
    
    func updateTaskStatus(_ isCompleted: Bool) {
        currentTask?.isCompleted = isCompleted
        guard let updatedTask = currentTask else { return }
                
        useCase.updateTaskStatus(updatedTask)
        getTasks()
        
        resetUnlockedRewardsIfNeeded()

    }
}
