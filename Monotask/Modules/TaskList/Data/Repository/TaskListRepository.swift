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
                print(updatedTask.isCompleted)
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
