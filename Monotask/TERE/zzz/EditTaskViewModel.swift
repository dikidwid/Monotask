//
//  EditTaskViewModel.swift
//  Monotask
//
//  Created by Theresia Angela Ayrin on 20/08/24.
//

import Foundation
import SwiftUI

class EditTaskViewModel: CreateTaskViewModel {
    
    init(task: Task) {
        super.init()
        self.task = task
    }
    
    func updateTitle(_ newTitle: String) {
        task.title = newTitle
    }
    
    func updateSubtask(at index: Int, with newTitle: String) {
        guard index >= 0 && index < task.subtasks.count else { return }
        task.subtasks[index].title = newTitle
    }
    
    override func updateReminderDate(_ newDate: Date) {
        task.reminderDate = newDate
    }
    
    func deleteSubtask(at index: Int) {
        guard index >= 0 && index < task.subtasks.count else { return }
        task.subtasks.remove(at: index)
    }
    
    func saveChanges() {
        print("Task updated: \(task)")
    }
}

