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
    @Published var isReminderOn: Bool = false
    @Published var reminderTime: Date = .now
    @Published var selectedUrgencyParameter: TaskUrgency?
    @Published var selectedDifficultyParameter: TaskDifficulty?
    @Published var selectedFunParameter: TaskFun?
    
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
    
    let useCase: AddTaskUseCase
    let audioManager = AudioManager.shared
    
    init(useCase: AddTaskUseCase) {
        self.useCase = useCase
    }
    
    func addSubtask() {
        let newSubtask = SubtaskModel(title: subtaskName)
        subtasks.append(newSubtask)
        subtaskName = ""
    }
    
    func checkMaxTaskNameCharacters() {
        if taskName.count > maximumCharacterTaskName {
            taskName = String(taskName.prefix(maximumCharacterTaskName))
        }
        print(taskName)
    }
    
    func deleteSubtask(_ subtask: SubtaskModel) {
        subtasks.removeAll { $0.id == subtask.id }
    }
    
    func addNewTask() {
        #warning("Ask mentors, should we create a DTO for creating this object into SwiftData?")
        let newTask = TaskModel(id: UUID().uuidString,
                                taskName: taskName,
                                isCompleted: false,
                                subtasks: subtasks.map({ $0.title }),
                                reminderTime: reminderTime,
                                difficultyMetric: selectedDifficultyParameter?.value ?? 1,
                                interestMetric: selectedFunParameter?.value ?? 1,
                                urgencyMetric: selectedUrgencyParameter?.value ?? 1)
        
        print(newTask)
        useCase.addNewTask(newTask)
    }
    
    
}
