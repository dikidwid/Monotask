//
//  GetTasksUseCase.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

protocol GetTasksUseCase {
    func getTasks() -> [TaskModel]
}
