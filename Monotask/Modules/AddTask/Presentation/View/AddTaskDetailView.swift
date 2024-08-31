//
//  AddTaskView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct AddTaskDetailView: View {
    @StateObject var addTaskViewModel: AddTaskViewModel
    @FocusState private var isFieldFocused: FocusedField?
    @EnvironmentObject private var coordinator: AddTaskCoordinator
    let onDismiss: (() -> Void)
    
    enum FocusedField {
        case taskName, subtaskName
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                taskNameTextField
                
                subtaskTextField
                
                reminderTask
            }
            .padding(.top, 90)
            .padding(.horizontal, 38)
        }
        .animation(.interpolatingSpring, value: addTaskViewModel.subtasks)
        .overlay {
            VStack {
                customNavigationBar
                
                Spacer()
                
                if isFieldFocused == nil{
                    nextButton
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    isFieldFocused = nil
                }
                .tint(.black)
            }
        }
        
    }
}

#Preview {
    let repository = AddTaskRepositoryImpl()
    let useCase = AddTaskUseCaseImpl(repository: repository)
    let viewModel = AddTaskViewModel(useCase: useCase)
    
    return AddTaskDetailView(addTaskViewModel: viewModel, onDismiss: { })
}

// MARK: - Private
// Extension for create each component in the view
extension AddTaskDetailView {
    var taskNameTextField: some View {
        VStack(spacing: 15) {
            HStack {
                TitleView(text: String(localized: "Task Name"))
                
                Text("\(addTaskViewModel.taskName.count) / \(addTaskViewModel.maximumCharacterTaskName)")
                    .font(.oswaldFootnote)
            }
            
            TextField("Write down your task...", text: $addTaskViewModel.taskName)
                .font(.oswaldBody)
                .textFieldStyle(CustomTextFieldStyle(isTextfieldEmpty: addTaskViewModel.isSubtaskNameFieldEmpty,
                                                     isShowSubmitButton: false))
                .focused($isFieldFocused, equals: .taskName)
                .submitLabel(.next)
                .onSubmit { isFieldFocused = .subtaskName }
        }
        .onChange(of: addTaskViewModel.taskName, addTaskViewModel.checkMaxTaskNameCharacters)
    }
    
    var subtaskTextField: some View {
        VStack(spacing: 15) {
            TitleView(text: String(localized: "Subtasks"))
            
            ForEach(addTaskViewModel.subtasks) { subtask in
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .fontWeight(.semibold)
                    
                    Text(subtask.title)
                        .font(.oswaldSubhead)
                    
                    Spacer()
                    
                    Button {
                        addTaskViewModel.deleteSubtask(subtask)
                    } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .tint(.black)
                    }
                    .frame(width: 36, height: 36)
                }
            }
            
            TextField("Break down your task here...", text: $addTaskViewModel.subtaskName)
                .textFieldStyle(CustomTextFieldStyle(isTextfieldEmpty: addTaskViewModel.isSubtaskNameFieldEmpty,
                                                     isShowSubmitButton: true,
                                                     onSubmit: addTaskViewModel.addSubtask))
                .focused($isFieldFocused, equals: .subtaskName)
                .submitLabel(.go)
                .onSubmit(addTaskViewModel.addSubtask)
        }
    }
    
    var reminderTask: some View {
        VStack(spacing: 15) {
            HStack {
                
                Toggle(isOn: $addTaskViewModel.isReminderOn) {
                    TitleView(text: String(localized: "Reminder"))
                }
                .toggleStyle(SwitchToggleStyle(tint: .appAccentColor))
            }
            
            if addTaskViewModel.isReminderOn {
                VStack {
                    DatePicker(selection: $addTaskViewModel.reminderTime, displayedComponents: .hourAndMinute) {
                       Text("Task Reminder")
                    }
                }
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            }
        }
        .padding(.bottom, UIScreen.main.bounds.height / 8)
    }
    
    var customNavigationBar: some View {
        CustomAddTaskNavigationBar(navigationTitle: String(localized: "New Task")) {
            onDismiss()
        }
    }
    
    var nextButton: some View {
        CustomAddTaskActionButton(name: String(localized: "Next"), icon: "chevron.right", isTaskNameFieldEmpty: addTaskViewModel.isTaskNameFieldEmpty) {
            coordinator.isShowAddTaskPrioritization.toggle()
        }
    }
}
