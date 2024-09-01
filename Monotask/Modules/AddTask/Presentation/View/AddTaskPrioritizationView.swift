//
//  TaskPrioritizationView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct AddTaskPrioritizationView: View {
    @ObservedObject var addTaskViewModel: AddTaskViewModel
    @EnvironmentObject var coordinator: AddTaskCoordinator
    let onDismiss: ((TaskModel) -> Void?)
    
    var body: some View {
        VStack(alignment: .leading) {
            prioritizeTitle
            
            VStack(alignment: .center, spacing: 25) {
                urgencyParameterSelection
                
                difficultyParameterSelection
                
                funParameterSelection
                
                Spacer()
            }
            .tint(.black)
        }
        .padding(.top, 90)
        .padding(.horizontal, 32)
        .overlay {
            VStack {
                customNavigationBar
                
                Spacer()
                
                confirmButton
            }
        }
    }
}

#Preview {
    let repository = AddTaskRepositoryImpl()
    let useCase = AddTaskUseCaseImpl(repository: repository)
    let viewModel = AddTaskViewModel(useCase: useCase)
    
    return AddTaskPrioritizationView(addTaskViewModel: viewModel, onDismiss: { _ in })
}


extension AddTaskPrioritizationView {
    var prioritizeTitle: some View {
        TitleView(text: String(localized: "Let's prioritize your task"))
            .padding(.bottom, 8)
    }
    
    var urgencyParameterSelection: some View {
        VStack {
            TitleParameterTaskView(title: String(localized: "Urgency"),
                                   information: String(localized: "How quick this task needs to be completed?"))
            
            HStack(alignment: .top ,spacing: 75) {
                ForEach(TaskUrgency.allCases, id: \.self) { parameter in
                    Button {
                        addTaskViewModel.selectedUrgencyParameter = parameter
                        
                    } label: {
                        SelectionParameterTaskView(isSelected: addTaskViewModel.selectedUrgencyParameter == parameter,
                                                   enabledImage: parameter.enabledImage,
                                                   disabledImage: parameter.disabledImage,
                                                   description: parameter.description)
                    }
                }
            }
        }
        .animation(.interpolatingSpring, value: addTaskViewModel.selectedUrgencyParameter)
    }
    
    var difficultyParameterSelection: some View {
        VStack {
            TitleParameterTaskView(title: String(localized: "Difficulty"),
                                   information: String(localized: "How challenging is this task for you?"))
            
            HStack(alignment: .top ,spacing: 75) {
                ForEach(TaskDifficulty.allCases) { parameter in
                    Button {
                        addTaskViewModel.selectedDifficultyParameter = parameter
                    } label: {
                        SelectionParameterTaskView(isSelected: addTaskViewModel.selectedDifficultyParameter == parameter,
                                                   enabledImage: parameter.enabledImage,
                                                   disabledImage: parameter.disabledImage,
                                                   description: parameter.description)
                    }
                }
            }
        }
        .animation(.interpolatingSpring, value: addTaskViewModel.selectedDifficultyParameter)
    }
    
    var funParameterSelection: some View {
        VStack {
            TitleParameterTaskView(title: String(localized: "Fun"),
                                   information: String(localized: "How fun is this task for you?"))

            HStack(alignment: .top ,spacing: 75) {
                ForEach(TaskFun.allCases) { parameter in
                    Button {
                        addTaskViewModel.selectedFunParameter = parameter
                    } label: {
                        SelectionParameterTaskView(isSelected: addTaskViewModel.selectedFunParameter == parameter,
                                                   enabledImage: parameter.enabledImage,
                                                   disabledImage: parameter.disabledImage,
                                                   description: parameter.description)
                    }
                }
            }
        }
        .animation(.interpolatingSpring, value: addTaskViewModel.selectedFunParameter)
    }
    
    var customNavigationBar: some View {
        CustomAddTaskNavigationBar(navigationTitle: String(localized: "New Task")) {
            coordinator.isShowAddTaskPrioritization.toggle()
        }
    }
    
    var confirmButton: some View {
        CustomAddTaskActionButton(name: String(localized: "Done"), icon: "checkmark", isTaskNameFieldEmpty: addTaskViewModel.isTaskNameFieldEmpty) {
            addTaskViewModel.addNewTask(onDismiss)
            addTaskViewModel.audioManager.playAudioPlayerOne(.created)
            coordinator.isShowAddTaskPrioritization.toggle()
        }
    }
}
