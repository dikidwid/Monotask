//
//  TaskListLocalEntity.swift
//  MC3
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import Foundation
import SwiftData

@Model
class TaskLocalEntity {
    @Attribute(.unique)
    var id: String
    var taskName: String
    var isCompleted: Bool
    var subtasks: [String]
    var reminderTime: Date
    var urgencyMetric: Int
    var difficultyMetric: Int
    var interestMetric: Int
    
    init(
        id: String,
        taskName: String,
        isCompleted: Bool,
        subtasks: [String],
        reminderTime: Date,
        urgencyMetric: Int,
        difficultyMetric: Int,
        interestMetric: Int
    ) {
        self.id = id
        self.taskName = taskName
        self.isCompleted = isCompleted
        self.subtasks = subtasks
        self.reminderTime = reminderTime
        self.urgencyMetric = urgencyMetric
        self.difficultyMetric = difficultyMetric
        self.interestMetric = interestMetric
    }
}

extension TaskLocalEntity {
    func toDomain() -> TaskModel {
        .init(
            id: self.id,
            taskName: self.taskName,
            isCompleted: self.isCompleted,
            subtasks: self.subtasks,
            reminderTime: self.reminderTime,
            urgencyMetric: self.urgencyMetric,
            difficultyMetric: self.difficultyMetric,
            interestMetric: self.interestMetric
        )
    }
}
