//
//  TaskListUseCase.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

protocol TaskListUseCase {
    func getTasks() -> [TaskModel]
    func createNewTask(_ newTask: TaskModel)
    func updateTaskStatus(_ updatedTask: TaskModel)
}

struct TaskListUseCaseImpl: TaskListUseCase {
    let repository: TaskListRepository
    
    func getTasks() -> [TaskModel] {
        repository.fetchTasks()
    }
    
    func createNewTask(_ newTask: TaskModel) {
        repository.createTask(newTask)
    }
    
    func updateTaskStatus(_ updatedTask: TaskModel) {
        repository.updateTask(updatedTask)
    }
}
