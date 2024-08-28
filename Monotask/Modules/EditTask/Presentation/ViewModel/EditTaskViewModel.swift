//
//  EditTaskViewModel.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import Foundation
import SwiftUI

class EditTaskViewModel: ObservableObject {
    @Published var taskName: String
    @Published var subtaskName: String = ""
    @Published var subtasks: [String]
    @Published var isReminderOn: Bool
    @Published var reminderTime: Date
    @Published var selectedUrgencyParameter: TaskUrgency
    @Published var selectedDifficultyParameter: TaskDifficulty
    @Published var selectedFunParameter: TaskFun
    
    @Published var isShowNextAddTaskScreen: Bool = false
    
    let whiteGradient: [Color] = [.clear,
                                 .white.opacity(1),
                                 .white.opacity(1)]
    
    let maximumCharacterTaskName: Int = 24
    
    var isTaskNameFieldEmpty: Bool {
        taskName.isEmpty
    }
    
    var isSubtaskNameFieldEmpty: Bool {
        subtaskName.isEmpty
    }
    
    let useCase: EditTaskUseCase
    let taskID: String
    let audioManager = AudioManager.shared
    let localNotificationManager = LocalNotificationManager.shared
    
    init(taskID: String, useCase: EditTaskUseCase) {
        let task = useCase.getTask(taskID)
        self.taskID = taskID
        self.taskName = task.taskName
        self.subtasks = task.subtasks
        self.isReminderOn = task.reminderTime != nil ? true : false
        self.reminderTime = task.reminderTime ?? .now
        self.selectedUrgencyParameter = task.urgencyMetric
        self.selectedDifficultyParameter = task.difficultyMetric
        self.selectedFunParameter = task.interestMetric
        self.useCase = useCase
        print(task)
    }
    
    func addSubtask() {
        guard !subtaskName.isEmpty else { return }
        subtasks.append(subtaskName)
        subtaskName = ""
    }
    
    func checkMaxTaskNameCharacters() {
        if taskName.count > maximumCharacterTaskName {
            taskName = String(taskName.prefix(maximumCharacterTaskName))
        }
    }
    
    func deleteSubtask(_ subtask: String) {
        subtasks.removeAll { $0 == subtask }
    }
    
    func editTask(_ onDismiss: @escaping ((TaskModel) -> Void?)) {
        setLocalNotification()
        
        #warning("Ask mentors, should we create a DTO for creating this object into SwiftData?")
        let editedTask = TaskModel(id: taskID,
                                   taskName: taskName,
                                   isCompleted: false,
                                   subtasks: subtasks,
                                   reminderTime: isReminderOn ? reminderTime : nil,
                                   urgencyMetric: selectedUrgencyParameter,
                                   difficultyMetric: selectedDifficultyParameter,
                                   interestMetric: selectedFunParameter)
        
        useCase.editTask(editedTask)
        
        resetAllField()
        
        onDismiss(editedTask)
    }
    
    func resetAllField() {
        taskName = ""
        subtaskName = ""
        subtasks = []
        isReminderOn = false
        selectedUrgencyParameter = .notUrgent
        selectedDifficultyParameter = .easy
        selectedFunParameter = .notFun
    }
    
    func setLocalNotification() {
//        guard let reminderTime else { return }
        
        localNotificationManager.cancelScheduledNotificationBefore(id: taskID)
        
        localNotificationManager.scheduleNotification(id: taskID,
                                                      notificationTitle: taskName,
                                                      notificationMessage: "Don’t forget that you still have this task.",
                                                      reminderTime: reminderTime)
    }
}
