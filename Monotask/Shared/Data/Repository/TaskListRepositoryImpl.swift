//
//  TaskListRepositoryImpl.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation
import SwiftData

struct TaskListRepositoryImpl: TaskListRepository {
    
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor
    func fetchTasks() -> [TaskModel] {
        do {
#warning("TODO: Dummy data purpose, telete this if you want to:D")
            let totalLocalTasks = try self.container.mainContext.fetch(FetchDescriptor<TaskLocalEntity>())
            if totalLocalTasks.count == 0 {
                let firstTask = TaskLocalEntity(id: UUID().uuidString,
                                                taskName: "Task 1",
                                                isCompleted: true,
                                                subtasks: [],
                                                reminderTime: Date(),
                                                urgencyMetric: 1,
                                                difficultyMetric: 2,
                                                interestMetric: 3)

                let secondTask = TaskLocalEntity(id: UUID().uuidString,
                                                 taskName: "Task 2",
                                                 isCompleted: true,
                                                 subtasks: [],
                                                 reminderTime: Date(),
                                                 urgencyMetric: 2,
                                                 difficultyMetric: 2,
                                                 interestMetric: 2)
                
                let thirdTask = TaskLocalEntity(id: UUID().uuidString,
                                                taskName: "Task 3",
                                                isCompleted: true,
                                                subtasks: [],
                                                reminderTime: Date(),
                                                urgencyMetric: 2,
                                                difficultyMetric: 2,
                                                interestMetric: 1)
                
                container.mainContext.insert(firstTask)
                container.mainContext.insert(secondTask)
                container.mainContext.insert(thirdTask)
            }
            
            let fetchDescriptor = FetchDescriptor<TaskLocalEntity>(sortBy: [SortDescriptor(\TaskLocalEntity.taskName)])
            let localTasks = try self.container.mainContext.fetch(fetchDescriptor)
            let domainModels = localTasks.compactMap { $0.toDomain() }
            
            print(localTasks.count)
            return domainModels
        } catch {
            fatalError("Error fetching from TaskListRepositoryImpl:\(error)")
        }
    }
    
    @MainActor
    func updateTask(_ updatedTask: TaskModel) {
        do {
            let fetchDescriptor = FetchDescriptor<TaskLocalEntity>()
            let localTasks = try self.container.mainContext.fetch(fetchDescriptor)
            
            if let existingTask = localTasks.first(where: { $0.id == updatedTask.id }) {
                existingTask.isCompleted = updatedTask.isCompleted
                try self.container.mainContext.save()
            }
        } catch {
            fatalError("Error updating from TaskListRepositoryImpl:\(error)")
        }
    }
    
    @MainActor
    func fetchRewards() -> [RewardModel] {
        do {
            // Fetch the existing rewards from the local storage
            let fetchDescriptor = FetchDescriptor<RewardLocalEntity>(sortBy: [SortDescriptor(\RewardLocalEntity.rewardNumber)])
            let localRewards = try self.container.mainContext.fetch(fetchDescriptor)
            
            // If rewards already exist, return them without reinitializing
            if !localRewards.isEmpty {
                return localRewards.compactMap { $0.toDomainReward() }
            }
            
            // If no rewards exist, initialize the predefined rewards
            let firstReward = RewardLocalEntity(id: "Stage1",
                                                rewardNumber: 1,
                                                rewardName: "The Hope",
                                                rewardDescription: "Patience and care in fostering new beginnings.",
                                                rewardWallpaper: "wallpaperWater",
                                                rewardPresentImage: "artWaterPreview",
                                                minimumTask: 3,
                                                isUnlockedTap: false)
            
            let secondReward = RewardLocalEntity(id: "Stage2",
                                                 rewardNumber: 2,
                                                 rewardName: "The Light",
                                                 rewardDescription: "Golden flowers, now in full bloom, illuminated the path ahead.",
                                                 rewardWallpaper: "wallpaperHold",
                                                 rewardPresentImage: "artHoldPreview",
                                                 minimumTask: 5,
                                                 isUnlockedTap: false)
            
            let thirdReward = RewardLocalEntity(id: "Stage3",
                                                rewardNumber: 3,
                                                rewardName: "The Star",
                                                rewardDescription: "Amidst the challenges, a star is preserved as something pure.",
                                                rewardWallpaper: "wallpaperStar",
                                                rewardPresentImage: "artStarPreview",
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
