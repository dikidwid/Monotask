//
//  CreateTaskModel.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import Foundation

enum Urgency: Int {
    case illWait = 1
    case actSoon = 2
    case asap = 3
}

enum Difficulty: Int {
    case simple = 1
    case challenging = 2
    case intense = 3
}

enum Interest: Int {
    case mild = 1
    case engaging = 2
    case captivating = 3
}

struct Task {
    var title: String
    var subtasks: [Subtask]
    var urgency: Urgency = .illWait
    var difficulty: Difficulty = .simple
    var interest: Interest = .mild
    var isReminderOn: Bool
    var reminderDate: Date?
}

struct Subtask: Identifiable {
    var id = UUID()
    var title: String
}
