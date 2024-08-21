//
//  RewardViewModel.swift
//  Monotask
//
//  Created by Felicia Himawan on 19/08/24.
//
import Foundation
import SwiftUI

final class RewardViewModel: ObservableObject {
    @Published var rewards: [RewardModel] = []
    @Published var tasks: [TaskModel] = []
    @Published var currentReward: RewardModel?
    @Published var currentIndexReward: Int?
    
    var lastReward: Int = 0
    private let useCaseReward: RewardListUseCase
    
    let whiteOverlay: [Color] = [.white.opacity(0.7),
                                   .clear,
                                   .clear,
                                   .clear,
                                   .white.opacity(0.7)]
    
    var totalCompletedTasks: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    var isRewardLocked: Bool {
        guard let currentReward else { return false }
        return currentReward.isUnlockedTap
    }
    
    init(useCaseReward: RewardListUseCase) {
        self.useCaseReward = useCaseReward
    }
    
    func fetchRewards() {
        rewards = useCaseReward.getRewards()
        tasks = useCaseReward.getTasks()
        
        currentReward = rewards.first
    }
    
    func unlockReward(_ reward: RewardModel) {
        var updatedReward = reward
        updatedReward.isUnlockedTap = true
        useCaseReward.updateReward(updatedReward)
        fetchRewards()
        print("Unlocked reward: \(updatedReward.rewardName)")
    }
    
    func resetUnlockedRewardsIfNeeded() {
            var updatedRewards = rewards
            
            for index in updatedRewards.indices {
                var reward = updatedRewards[index]
                if totalCompletedTasks < reward.minimumTask {
                    reward.isUnlockedTap = false
                    useCaseReward.updateReward(reward)
                    print("Reset reward: \(reward.rewardName) to locked")
                }
            }
            
            rewards = updatedRewards
        }
    
    func updateCurrentRewardState() {
        // Re-check the current reward based on the latest task completion status
        if let currentReward = currentReward, totalCompletedTasks < currentReward.minimumTask {
            var updatedReward = currentReward
            updatedReward.isUnlockedTap = false
            useCaseReward.updateReward(updatedReward)
            fetchRewards() // Refetch to update the UI with the latest state
            print("Reset reward: \(updatedReward.rewardName) to locked")
        }
    }
    
}
