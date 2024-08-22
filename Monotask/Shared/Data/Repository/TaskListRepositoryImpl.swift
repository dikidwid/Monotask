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
}