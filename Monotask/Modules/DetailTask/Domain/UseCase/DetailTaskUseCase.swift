//
//  DetailTaskUseCase.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 22/08/24.
//

import Foundation

protocol DetailTaskUseCase {
    func deleteTask(_ task: TaskModel)
}

struct DetailTaskUseCaseImpl: DetailTaskUseCase {
    let repository: DetailTaskRepository
    
    func deleteTask(_ task: TaskModel) {
        repository.deleteTask(task.id)
    }
}
