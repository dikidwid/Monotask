//
//  TaskListUseCase.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

protocol TaskListUseCase: GetTasksUseCase {
    func getTasks() -> [TaskModel]
    func updateTaskStatus(_ updatedTask: TaskModel)
}

struct TaskListUseCaseImpl: TaskListUseCase {
    let repository: TaskListRepository
    
    #warning("TODO: Create logic to sort the task based on those 3 parameters")
    func getTasks() -> [TaskModel] {
        let tasks = repository.fetchTasks()
        let sortedTasksByMatrixParamaters: [TaskModel] = tasks.sorted { task1, task2 in
            if task1.urgencyMetric != task2.urgencyMetric {
                return task1.urgencyMetric > task2.urgencyMetric
            } else if task1.difficultyMetric != task2.difficultyMetric {
                return task1.difficultyMetric < task2.difficultyMetric
            } else {
                return task1.interestMetric > task2.interestMetric
            }
        }
        
        return sortedTasksByMatrixParamaters
    }
    
    func updateTaskStatus(_ updatedTask: TaskModel) {
        repository.updateTask(updatedTask)
    }
}
