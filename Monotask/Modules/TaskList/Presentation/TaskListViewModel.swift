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
    @Published var hasNewReward: Bool = false
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
        getTasks()
        currentTask = tasks.first
    }
    
    func setAddedTask(_ newTask: TaskModel) {
        getTasks()
        currentTask = newTask
    }
    
    func getTasks() {
        tasks = useCase.getTasks()
        
        checkIsGetNewReward()
    }
    
    func updateTaskStatus(_ isCompleted: Bool) {
        currentTask?.isCompleted = isCompleted
        guard let updatedTask = currentTask else { return }
        useCase.updateTaskStatus(updatedTask)
        
        getTasks()
        
        checkUnlockedRewardStatus()
        
        automaticSlideToNextTask()
    }
    
    private func checkIsGetNewReward() {
        let rewards = useCase.getRewards()
        
        if let unlockedReward = rewards.first(where: { $0.isUnlockedTap == false }) {
            if totalCompletedTasks >= unlockedReward.minimumTask {
                hasNewReward = true
            } else {
                hasNewReward = false
            }
        }
    }
    
    private func checkUnlockedRewardStatus() {
        let rewards = useCase.getRewards()
        
        for index in rewards.indices {
            var reward = rewards[index]
            if totalCompletedTasks < reward.minimumTask {
                reward.isUnlockedTap = false
                useCase.updateReward(reward)
            }
        }
    }
    
    private func automaticSlideToNextTask() {
        guard let updatedTask = currentTask,
              updatedTask.isCompleted == true,
              let nextTaskIndex = tasks.firstIndex(where: { $0.isCompleted == false }),
              let currentTaskIndex = tasks.firstIndex(of: updatedTask),
              currentTaskIndex < tasks.count - 1
        else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
            withAnimation {
                self.currentTask = self.tasks[nextTaskIndex]
            }
        }
    }
}
