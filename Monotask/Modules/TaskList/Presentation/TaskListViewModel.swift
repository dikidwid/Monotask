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
    
    @Published var showInstructionsOverlay: Bool = false
    
    @Published var instructionText = String(localized: "Hold to mark as done")
    
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
        checkFirstLaunch()
    }
    
    func setCurrentTask(to task: TaskModel?) {
        getTasks()
        if let existingTask = tasks.first(where: { $0.id == task?.id }) {
            currentTask = existingTask
        }
        
        showInstructionsOverlayIfNeeded()
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
        
        // Handle instruction text update for the first task
        if let firstTask = tasks.first {
            handleInstructionTextUpdate(for: firstTask)
        }
        
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
    
    private func checkFirstLaunch() {
        // Check if this is the first launch
        let hasShownInstructions = UserDefaults.standard.bool(forKey: "hasShownInstructions")
        if !hasShownInstructions {
            // If tasks count becomes 1 on the first launch, show the overlay
            showInstructionsOverlayIfNeeded()
        }
    }
    
    private func showInstructionsOverlayIfNeeded() {
        // Show overlay if tasks count is 1 and it hasn't been shown before
        if tasks.count == 1 && !UserDefaults.standard.bool(forKey: "hasShownInstructions") {
            showInstructionsOverlay = true
            // Set flag to ensure it doesn't show again
            UserDefaults.standard.set(true, forKey: "hasShownInstructions")
        }
    }
    
    private func dismissInstructionsOverlay() {
        showInstructionsOverlay = false
    }
    
    private func handleInstructionTextUpdate(for task: TaskModel) {
        // Check if the task is the first and only task created by the user
        if tasks.count == 1 && task.id == tasks.first?.id {
            if task.isCompleted {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(){
                        self.instructionText = String(localized: "Tap to uncheck")
                    }
                    
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adjust the delay as needed
                  
                    withAnimation(){
                        self.dismissInstructionsOverlay()
                    }
                }
            }
        }
    }
    
}
