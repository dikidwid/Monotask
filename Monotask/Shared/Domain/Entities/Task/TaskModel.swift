//
//  TaskModel.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

struct TaskModel: Identifiable, Hashable {
    let id: String
    let taskName: String
    var isCompleted: Bool
    let subtasks: [String]
    let reminderTime: Date
    let difficultyMetric: Int
    let interestMetric: Int
    let urgencyMetric: Int
}
