//
//  AddTaskViewModel.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

class AddTaskViewModel: ObservableObject {
    @Published var taskName: String = ""
    @Published var subtaskName: String = ""
    @Published var subtasks: [SubtaskModel] = []
    @Published var isReminderOn: Bool = false {
        didSet { localNotificationManager.requestNotificationAuthorization() }
    }
    @Published var reminderTime: Date = .now
    @Published var selectedUrgencyParameter: TaskUrgency = .notUrgent
    @Published var selectedDifficultyParameter: TaskDifficulty = .easy
    @Published var selectedFunParameter: TaskFun = .notFun
    
    @Published var isShowNextAddTaskScreen: Bool = false
    
    
    
    let maximumCharacterTaskName: Int = 24
    
    var isTaskNameFieldEmpty: Bool {
        taskName.isEmpty
    }
    
    var isSubtaskNameFieldEmpty: Bool {
        subtaskName.isEmpty
    }
    
    let useCase: AddTaskUseCase
    let audioManager = AudioManager.shared
    let localNotificationManager = LocalNotificationManager.shared
    
    init(useCase: AddTaskUseCase) {
        self.useCase = useCase
    }
    
    func addSubtask() {
        guard !subtaskName.isEmpty else { return }
        let newSubtask = SubtaskModel(title: subtaskName)
        subtasks.append(newSubtask)
        subtaskName = ""
    }
    
    func checkMaxTaskNameCharacters() {
        if taskName.count > maximumCharacterTaskName {
            taskName = String(taskName.prefix(maximumCharacterTaskName))
        }
    }
    
    func deleteSubtask(_ subtask: SubtaskModel) {
        subtasks.removeAll { $0.id == subtask.id }
    }
    
    func addNewTask(_ onAddedNewTask: @escaping ((TaskModel) -> Void?)) {
        let taskID: String = UUID().uuidString

        localNotificationManager.scheduleNotification(id: taskID,
                                                      notificationTitle: taskName,
                                                      notificationMessage: "Don’t forget that you still have this task.",
                                                      reminderTime: reminderTime)
        
        #warning("Ask mentors, should we create a DTO for creating this object into SwiftData?")
        let newTask = TaskModel(id: taskID,
                                taskName: taskName,
                                isCompleted: false,
                                subtasks: subtasks.map({ $0.title }),
                                reminderTime: isReminderOn ? reminderTime : nil,
                                urgencyMetric: selectedUrgencyParameter,
                                difficultyMetric: selectedDifficultyParameter,
                                interestMetric: selectedFunParameter)
        
        useCase.addNewTask(newTask)
        
        resetAllField()
        
        onAddedNewTask(newTask)
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
}
