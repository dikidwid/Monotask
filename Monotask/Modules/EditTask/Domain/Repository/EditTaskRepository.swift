//
//  EditTaskRepository.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import Foundation

protocol EditTaskRepository {
    func fetchTask() -> [TaskModel]
    func editTask(_ editedTask: TaskModel)
}
