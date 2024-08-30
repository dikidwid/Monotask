//
//  EditTaskRepositoryImpl.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import Foundation
import SwiftData

struct EditTaskRepositoryImpl: EditTaskRepository {
    
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor
    func fetchTask() -> [TaskModel] {
        do {
            let tasks = try self.container.mainContext.fetch(FetchDescriptor<TaskLocalEntity>())
            return tasks.map { $0.toDomain() }
        } catch {
            fatalError("Error deleting in SwiftDataManager")
        }
    }
    
    @MainActor
    func editTask(_ editedTask: TaskModel) {
        do {
            let tasks = try self.container.mainContext.fetch(FetchDescriptor<TaskLocalEntity>())
            if let task = tasks.first(where: { $0.id == editedTask.id }) {
                task.taskName = editedTask.taskName
                task.subtasks = editedTask.subtasks
                task.reminderTime = editedTask.reminderTime
                task.urgencyMetric = editedTask.urgencyMetric.value
                task.difficultyMetric = editedTask.difficultyMetric.value
                task.interestMetric = editedTask.interestMetric.value
                try container.mainContext.save()
                
                print(task)
            }
           
        } catch {
            fatalError("Error deleting on SwiftDataManager")
        }
    }
}
