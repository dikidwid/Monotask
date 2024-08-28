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
    var reminderTime: Date?
    var urgencyMetric: Int
    var difficultyMetric: Int
    var interestMetric: Int
    
    init(
        id: String,
        taskName: String,
        isCompleted: Bool,
        subtasks: [String],
        reminderTime: Date?,
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
            urgencyMetric: getUrgencyLevel(self.urgencyMetric),
            difficultyMetric: getDifficultyLevel(self.difficultyMetric),
            interestMetric: getFunLevel(self.interestMetric)
        )
    }
    
    func getUrgencyLevel(_ urgencyValue: Int) -> TaskUrgency {
        switch urgencyValue {
        case 1:
            return .notUrgent
        case 2:
            return .lessUrgent
        case 3:
            return .urgent
        default:
            return .notUrgent
        }
    }
    
    func getDifficultyLevel(_ difficultyValue: Int) -> TaskDifficulty {
        switch difficultyValue {
        case 1:
            return .easy
        case 2:
            return .medium
        case 3:
            return .hard
        default:
            return .easy
        }
    }
    
    func getFunLevel(_ funValue: Int) -> TaskFun {
        switch funValue {
        case 1:
            return .notFun
        case 2:
            return .neutral
        case 3:
            return .fun
        default:
            return .notFun
        }
    }
}
