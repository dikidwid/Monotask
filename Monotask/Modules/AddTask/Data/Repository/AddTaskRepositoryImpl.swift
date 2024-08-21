//
//  AddTaskRepositoryImpl.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

struct AddTaskRepositoryImpl: AddTaskRepository{
    
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor
    func addNewTask(_ newTask: TaskModel) {
        let task = TaskLocalEntity(id: newTask.id,
                                   taskName: newTask.taskName,
                                   isCompleted: newTask.isCompleted,
                                   subtasks: newTask.subtasks,
                                   reminderTime: newTask.reminderTime,
                                   difficultyMetric: newTask.difficultyMetric,
                                   interestMetric: newTask.interestMetric,
                                   urgencyMetric: newTask.urgencyMetric)
        
        container.mainContext.insert(task)
        
        print("inserted")
    }
}
