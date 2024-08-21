//
//  AddTaskView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct AddTaskDetailView: View {
    @StateObject var addTaskViewModel: AddTaskViewModel
    @EnvironmentObject private var coordinator: AddTaskCoordinator
    let onDismiss: (() -> Void)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    taskNameTextField
                    
                    subtaskTextField
                    
                    reminderTask
                }
                .padding(.top, 66)
                .padding(.horizontal, 38)
            }
            .animation(.interpolatingSpring, value: addTaskViewModel.subtasks)
            .overlay {
                VStack {
                    customNavigationBar
                    
                    Spacer()
                    
                    nextButton
                }
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
                TitleView(text: "Task Name")
                
                Text("\(addTaskViewModel.taskName.count) / \(addTaskViewModel.maximumCharacterTaskName)")
                    .font(.oswaldFootnote)
            }
            
            TextField("Write down your task...", text: $addTaskViewModel.taskName)
                .font(.oswaldBody)
                .textFieldStyle(CustomTextFieldStyle(isTextfieldEmpty: addTaskViewModel.isSubtaskNameFieldEmpty,
                                                     isShowSubmitButton: false))
        }
        .onChange(of: addTaskViewModel.taskName) { _, newValue in
            addTaskViewModel.checkMaxTaskNameCharacters()
        }
    }
    
    var subtaskTextField: some View {
        VStack(spacing: 15) {
            TitleView(text: "Subtasks")
            
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
        }
    }
    
    var reminderTask: some View {
        VStack(spacing: 15) {
            HStack {
                
                Toggle(isOn: $addTaskViewModel.isReminderOn) {
                    TitleView(text: "Reminder")
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
        LinearGradient(colors: addTaskViewModel.whiteGradient, startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea(edges: .top)
            .frame(height: 90)
            .overlay(alignment: .top) {
                Text("New Task")
                    .font(.oswaldTitle1)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Button {
                            onDismiss()
                        } label: {
                            Circle()
                        }
                        .buttonStyle(CustomCircleButtonStyle(systemName: "chevron.left"))
                    }
                    .padding(.horizontal, 38)
            }
    }
    
    var nextButton: some View {
        LinearGradient(colors: addTaskViewModel.whiteGradient, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 90)
            .overlay {
                Button {
                    coordinator.isShowAddTaskPrioritization.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Text("Next")
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 5)
                }
                .buttonStyle(CallToActionButtonStyle(isDisable: addTaskViewModel.isTaskNameFieldEmpty))
                .disabled(addTaskViewModel.isTaskNameFieldEmpty)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 10)
            }
    }
}
