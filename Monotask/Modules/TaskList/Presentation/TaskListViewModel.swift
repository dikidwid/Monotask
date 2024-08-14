//
//  TaskListViewModel.swift
//  MC3
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import Foundation
import SwiftUI

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    @Published var selectedTask: TaskModel?
    
    let useCase: TaskListUseCase
    
    init(useCase: TaskListUseCase) {
        self.useCase = useCase
    }
    
    func getTasks() {
       tasks = useCase.getTasks()
    }
    
    func addNewTask() {
        let newTask = TaskModel(id: UUID().uuidString,
                                taskName: "New task",
                                isCompleted: false,
                                subtasks: [],
                                reminderTime: .now,
                                difficultyMetric: 1,
                                interestMetric: 1,
                                urgencyMetric: 1)
        
        useCase.createNewTask(newTask)
        getTasks()
    }
    
    func updateTaskStatus(_ updatedTask: Binding<TaskModel>) {
        updatedTask.wrappedValue.isCompleted.toggle()
        useCase.updateTaskStatus(updatedTask.wrappedValue)
        getTasks()
    }
}
