//
//  EditTaskUseCase.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import Foundation

protocol EditTaskUseCase {
    func getTask(_ taskID: String) -> TaskModel
    func editTask(_ editedTask: TaskModel)
}

struct EditTaskUseCaseImpl: EditTaskUseCase {
    let repository: EditTaskRepository
    
    func getTask(_ taskID: String) -> TaskModel {
        let fetchedTasks = repository.fetchTask()
        if let foundedTask = fetchedTasks.first(where: { $0.id == taskID }) {
            return foundedTask
        } else {
            return .init(id: "", taskName: "", isCompleted: false, subtasks: [], reminderTime: .now, urgencyMetric: .notUrgent, difficultyMetric: .easy, interestMetric: .notFun)
        }
    }
    
    func editTask(_ editedTask: TaskModel) {
        repository.editTask(editedTask)
    }
}
