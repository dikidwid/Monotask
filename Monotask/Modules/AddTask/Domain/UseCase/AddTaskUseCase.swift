//
//  AddTaskUseCase.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

protocol AddTaskUseCase {
    func addNewTask(_ task: TaskModel)
}

struct AddTaskUseCaseImpl: AddTaskUseCase {
    let repository: AddTaskRepository
    
    func addNewTask(_ task: TaskModel) {
        repository.addNewTask(task)
    }
}
