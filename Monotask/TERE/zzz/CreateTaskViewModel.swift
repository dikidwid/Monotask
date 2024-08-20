//
//  CreateTaskViewModel.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import Foundation
import SwiftUI

class CreateTaskViewModel: ObservableObject {
    @Published var task: Task = Task(title: "", subtasks: [], isReminderOn: false)
    @Published var newSubtask: String = ""

    func addSubtask() {
        guard !newSubtask.isEmpty else { return }
        task.subtasks.append(Subtask(title: newSubtask))
        newSubtask = ""
    }
    
    func updateReminderDate(_ newDate: Date) {
        task.reminderDate = newDate
    }
    
    func saveToEditTaskViewModel() -> EditTaskViewModel {
        return EditTaskViewModel(task: task)
    }
}
