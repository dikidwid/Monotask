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
    let audioManager: AudioManager = AudioManager.shared
    
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
    }
    
    func setCurrentReward() {
        currentReward = rewards.first
    }
    
    func unlockReward(_ reward: RewardModel) {
        var updatedReward = reward
        updatedReward.isUnlockedTap = true
        currentReward = updatedReward
        useCaseReward.updateReward(updatedReward)
        fetchRewards()
    }

    func playShowcaseSoundEffect() {
        audioManager.playAudioPlayerOne(.idled, volume: 0.09, atTime: 3)
    }
    
    func stopShowcaseSoundEffect() {
        audioManager.stopSound()
    }
}
