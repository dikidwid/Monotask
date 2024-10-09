//
//  EditTaskView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import SwiftUI

struct EditTaskDetailView: View {
    @StateObject var editTaskViewModel: EditTaskViewModel
    @FocusState private var isFieldFocused: FocusedField?
    @EnvironmentObject private var coordinator: AppCoordinator
    let onDismiss: ((TaskModel) -> Void)
    
    enum FocusedField {
        case taskName, subtaskName
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    taskNameTextField
                    
                    subtaskTextField
                    
                    reminderTask
                }
                .padding(.top, 90)
                .padding(.horizontal, 32)
            }
            .animation(.interpolatingSpring, value: editTaskViewModel.subtasks)
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
            .navigationDestination(isPresented: $editTaskViewModel.isShowNextAddTaskScreen) {
                EditTaskPrioritizationView(editTaskViewModel: editTaskViewModel, onDismiss: onDismiss)
            }
        }
    }
}

//#Preview {
//    let repository = EditTaskRepositoryImpl()
//    let useCase = EditTaskUseCaseImpl(repository: repository)
//    let viewModel = EditTaskViewModel(taskID: <#String#>, useCase: useCase)
//    
//    return EditTaskDetailView(editTaskViewModel: viewModel, onDismiss: { })
//}

// MARK: - Private
// Extension for create each component in the view
extension EditTaskDetailView {
    var taskNameTextField: some View {
        VStack(spacing: 15) {
            HStack {
                TitleView(text: String(localized: "Task Name"))
                
                Text("\(editTaskViewModel.taskName.count) / \(editTaskViewModel.maximumCharacterTaskName)")
                    .font(.oswaldFootnote)
            }
            
            TextField("Write down your task...", text: $editTaskViewModel.taskName)
                .font(.oswaldBody)
                .textFieldStyle(CustomTextFieldStyle(isTextfieldEmpty: editTaskViewModel.isSubtaskNameFieldEmpty,
                                                     isShowSubmitButton: false))
                .focused($isFieldFocused, equals: .taskName)
                .submitLabel(.next)
                .onSubmit { isFieldFocused = .subtaskName }
        }
        .onChange(of: editTaskViewModel.taskName, editTaskViewModel.checkMaxTaskNameCharacters)
    }
    
    var subtaskTextField: some View {
        VStack(spacing: 15) {
            TitleView(text: String(localized: "Subtasks"))
            
            ForEach(editTaskViewModel.subtasks, id: \.self) { subtask in
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .fontWeight(.semibold)
                    
                    Text(subtask)
                        .font(.oswaldSubhead)
                    
                    Spacer()
                    
                    Button {
                        editTaskViewModel.deleteSubtask(subtask)
                    } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .tint(.black)
                    }
                    .frame(width: 36, height: 36)
                }
            }
            
            TextField("Break down your task here...", text: $editTaskViewModel.subtaskName)
                .textFieldStyle(CustomTextFieldStyle(isTextfieldEmpty: editTaskViewModel.isSubtaskNameFieldEmpty,
                                                     isShowSubmitButton: true,
                                                     onSubmit: editTaskViewModel.addSubtask))
                .focused($isFieldFocused, equals: .subtaskName)
                .submitLabel(.go)
                .onSubmit(editTaskViewModel.addSubtask)
        }
    }
    
    var reminderTask: some View {
        VStack(spacing: 15) {
            HStack {
                
                Toggle(isOn: $editTaskViewModel.isReminderOn) {
                    TitleView(text: String(localized: "Reminder"))
                }
                .toggleStyle(SwitchToggleStyle(tint: .appAccentColor))
            }
            
            if editTaskViewModel.isReminderOn {
                VStack {
                    DatePicker(selection: $editTaskViewModel.reminderTime, displayedComponents: .hourAndMinute) {
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
        CustomAddTaskNavigationBar(navigationTitle: String(localized: "Edit Task")) {
            coordinator.dismissFullScreenOver()

        }
    }
    
    var nextButton: some View {
        CustomAddTaskActionButton(name: String(localized: "Next"), icon: "chevron.right", isTaskNameFieldEmpty: editTaskViewModel.isTaskNameFieldEmpty) {
            editTaskViewModel.isShowNextAddTaskScreen.toggle()
        }
    }
}
