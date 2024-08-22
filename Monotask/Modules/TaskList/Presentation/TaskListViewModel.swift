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
    @Published var currentTask: TaskModel?
    @Published var hasNewJourneyPiece: Bool = false
    @Published var isShowRemoveCheckmarkAlert: Bool =  false
    
    let useCase: TaskListUseCase
    
    let whiteOverlay: [Color] = [.white.opacity(0.7),
                                   .clear,
                                   .clear,
                                   .clear,
                                   .white.opacity(0.7)]
    
    var totalTasks: Int {
        tasks.count
    }
    
    var totalCompletedTasks: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    
    init(useCase: TaskListUseCase) {
        self.useCase = useCase
    }
    
    func onAppearAction() {
        getTasks()
        currentTask = tasks.first
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
                                urgencyMetric: 1, 
                                difficultyMetric: 1,
                                interestMetric: 1)
        
//        useCase.createNewTask(newTask)
        getTasks()
    }
    
    func updateTaskStatus(_ isCompleted: Bool) {
        currentTask?.isCompleted = isCompleted
        guard let updatedTask = currentTask else { return }
        useCase.updateTaskStatus(updatedTask)
        getTasks()
    }
}
