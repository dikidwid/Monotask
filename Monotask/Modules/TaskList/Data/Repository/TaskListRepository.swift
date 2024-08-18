//
//  TaskListRepository.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation
import SwiftData

protocol TaskListRepository {
    func fetchTasks() -> [TaskModel]
    func createTask(_ newTask: TaskModel)
    func updateTask(_ updatedTask: TaskModel)
}

struct TaskListRepositoryImpl: TaskListRepository {
    
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor 
    func fetchTasks() -> [TaskModel] {
        do {
            #warning("TODO: Dummy data purpose, telete this if you want to:D")
            let totalLocalTasks = try self.container.mainContext.fetch(FetchDescriptor<TaskLocalEntity>())
            if totalLocalTasks.count == 0 {
                let firstTask = TaskLocalEntity(id: UUID().uuidString,
                                           taskName: "Research on ADHD",
                                           isCompleted: false,
                                           subtasks: [],
                                           reminderTime: Date(),
                                           difficultyMetric: 0,
                                           interestMetric: 0,
                                           urgencyMetric: 0)
                
                
                let secondTask = TaskLocalEntity(id: UUID().uuidString,
                                           taskName: "Learning UIKit",
                                           isCompleted: false,
                                           subtasks: [],
                                           reminderTime: Date(),
                                           difficultyMetric: 0,
                                           interestMetric: 0,
                                           urgencyMetric: 0)
                
                let thirdTask = TaskLocalEntity(id: UUID().uuidString,
                                           taskName: "Implement Clean Architecture",
                                           isCompleted: false,
                                           subtasks: [],
                                           reminderTime: Date(),
                                           difficultyMetric: 0,
                                           interestMetric: 0,
                                           urgencyMetric: 0)
                
                container.mainContext.insert(firstTask)
                container.mainContext.insert(secondTask)
                container.mainContext.insert(thirdTask)
            }
            
            let fetchDescriptor = FetchDescriptor<TaskLocalEntity>(sortBy: [SortDescriptor(\TaskLocalEntity.taskName)])
            let localTasks = try self.container.mainContext.fetch(fetchDescriptor)
            let domainModels = localTasks.compactMap { $0.toDomain() }
            
            return domainModels
        } catch {
            fatalError("Error fetching from TaskListRepositoryImpl:\(error)")
        }
    }
    
    @MainActor
    func createTask(_ newTask: TaskModel) {
        let task = TaskLocalEntity(id: newTask.id,
                                   taskName: newTask.taskName,
                                   isCompleted: newTask.isCompleted,
                                   subtasks: newTask.subtasks,
                                   reminderTime: newTask.reminderTime,
                                   difficultyMetric: newTask.difficultyMetric,
                                   interestMetric: newTask.interestMetric,
                                   urgencyMetric: newTask.urgencyMetric)
        
        container.mainContext.insert(task)
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

struct TaskStatusDTO {
    let id: String
    let isCompleted: Bool
}
