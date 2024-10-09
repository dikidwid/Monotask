//
//  EditTaskPrioritizationView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import SwiftUI

struct EditTaskPrioritizationView: View {
    @ObservedObject var editTaskViewModel: EditTaskViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let repository = AddTaskRepositoryImpl()
    let useCase = AddTaskUseCaseImpl(repository: repository)
    let viewModel = AddTaskViewModel(useCase: useCase)
    
    return AddTaskPrioritizationView(addTaskViewModel: viewModel, onDismiss: { _ in })
}


extension EditTaskPrioritizationView {
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
                        editTaskViewModel.selectedUrgencyParameter = parameter
                        
                    } label: {
                        SelectionParameterTaskView(isSelected: editTaskViewModel.selectedUrgencyParameter == parameter,
                                                   enabledImage: parameter.enabledImage,
                                                   disabledImage: parameter.disabledImage,
                                                   description: parameter.description)
                    }
                }
            }
        }
        .animation(.interpolatingSpring, value: editTaskViewModel.selectedUrgencyParameter)
    }
    
    var difficultyParameterSelection: some View {
        VStack {
            TitleParameterTaskView(title: String(localized: "Difficulty"),
                                   information: String(localized: "How challenging is this task for you?"))
            
            HStack(alignment: .top ,spacing: 75) {
                ForEach(TaskDifficulty.allCases) { parameter in
                    Button {
                        editTaskViewModel.selectedDifficultyParameter = parameter
                    } label: {
                        SelectionParameterTaskView(isSelected: editTaskViewModel.selectedDifficultyParameter == parameter,
                                                   enabledImage: parameter.enabledImage,
                                                   disabledImage: parameter.disabledImage,
                                                   description: parameter.description)
                    }
                }
            }
        }
        .animation(.interpolatingSpring, value: editTaskViewModel.selectedDifficultyParameter)
    }
    
    var funParameterSelection: some View {
        VStack {
            TitleParameterTaskView(title: String(localized: "Fun"),
                                   information: String(localized: "How fun is this task for you?"))

            HStack(alignment: .top ,spacing: 75) {
                ForEach(TaskFun.allCases) { parameter in
                    Button {
                        editTaskViewModel.selectedFunParameter = parameter
                    } label: {
                        SelectionParameterTaskView(isSelected: editTaskViewModel.selectedFunParameter == parameter,
                                                   enabledImage: parameter.enabledImage,
                                                   disabledImage: parameter.disabledImage,
                                                   description: parameter.description)
                    }
                }
            }
        }
        .animation(.interpolatingSpring, value: editTaskViewModel.selectedFunParameter)
    }
    
    var customNavigationBar: some View {
        CustomAddTaskNavigationBar(navigationTitle: String(localized: "Edit Task")) {
            editTaskViewModel.isShowNextAddTaskScreen.toggle()
        }
    }
    
    var confirmButton: some View {
        CustomAddTaskActionButton(name: String(localized: "Save"), icon: "checkmark", isTaskNameFieldEmpty: editTaskViewModel.isTaskNameFieldEmpty) {
            editTaskViewModel.editTask(onDismiss)
            editTaskViewModel.audioManager.playAudioPlayerOne(.created)
            coordinator.dismissFullScreenOver()
        }
    }
}
