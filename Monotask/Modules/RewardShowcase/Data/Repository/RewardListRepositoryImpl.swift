//
//  RewardListRepositoryImpl.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation
import SwiftData

struct RewardListRepositoryImpl: RewardListRepository {
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor
    func fetchRewards() -> [RewardModel] {
        do {
            // Fetch the existing rewards from the local storage
            let fetchDescriptor = FetchDescriptor<RewardLocalEntity>(sortBy: [SortDescriptor(\RewardLocalEntity.rewardName)])
            let localRewards = try self.container.mainContext.fetch(fetchDescriptor)
            
            // If rewards already exist, return them without reinitializing
            if !localRewards.isEmpty {
                return localRewards.compactMap { $0.toDomainReward() }
            }
            
            // If no rewards exist, initialize the predefined rewards
            let firstReward = RewardLocalEntity(id: "1",
                                                rewardName: "The Angel",
                                                rewardDescription: "Amidst the challenges, a star is preserved as something pure. ",
                                                minimumTask: 3,
                                                isUnlockedTap: false)
            
            let secondReward = RewardLocalEntity(id: "2",
                                                 rewardName: "The second reward",
                                                 rewardDescription: "The second reward desc",
                                                 minimumTask: 5,
                                                 isUnlockedTap: false)
            
            let thirdReward = RewardLocalEntity(id: "3",
                                                rewardName: "The third reward",
                                                rewardDescription: "The third reward desc",
                                                minimumTask: 10,
                                                isUnlockedTap: false)
            
            // Insert the predefined rewards into the local storage
            container.mainContext.insert(firstReward)
            container.mainContext.insert(secondReward)
            container.mainContext.insert(thirdReward)
            
            // Save the context to persist the new rewards
            try self.container.mainContext.save()
            
            // Return the initialized rewards
            return [firstReward, secondReward, thirdReward].compactMap { $0.toDomainReward() }
            
        } catch {
            fatalError("Error fetching from RewardListRepositoryImpl: \(error)")
        }
    }
    
    
    @MainActor
    func updateReward(_ updatedReward: RewardModel) {
        do {
            // Fetch all the rewards
            let fetchDescriptor = FetchDescriptor<RewardLocalEntity>()
            let localRewards = try self.container.mainContext.fetch(fetchDescriptor)
            
            // Find the specific reward by its ID
            if let existingReward = localRewards.first(where: { $0.id == updatedReward.id }) {
                existingReward.isUnlockedTap = updatedReward.isUnlockedTap
                try self.container.mainContext.save()  // Save the changes to persist the update
            } else {
                print("Reward with id \(updatedReward.id) not found.")
            }
        } catch {
            fatalError("Error updating RewardListRepositoryImpl: \(error)")
        }
    }





    
}