//
//  TaskListUseCase.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

protocol TaskListUseCase {
    func getTasks() -> [TaskModel]
    func updateTaskStatus(_ updatedTask: TaskModel)
}

struct TaskListUseCaseImpl: TaskListUseCase {
    let repository: TaskListRepository
    
    #warning("TODO: Create logic to sort the task based on those 3 parameters")
    func getTasks() -> [TaskModel] {
        repository.fetchTasks()
    }
    
    func updateTaskStatus(_ updatedTask: TaskModel) {
        repository.updateTask(updatedTask)
    }
}
