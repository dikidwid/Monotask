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
    let onDismiss: (() -> Void?)
    
    var body: some View {
        VStack(alignment: .leading) {
            prioritizeTitle
            
            VStack(spacing: 25) {
                urgencyParameterSelection
                
                difficultyParameterSelection
                
                funParameterSelection
                
                Spacer()
            }
            .tint(.black)
        }
        .padding(.top, 66)
        .padding(.horizontal, 38)
        .overlay {
            VStack {
                customNavigationBar
                
                Spacer()
                
                confirmButton
            }
        }
        .onAppear {
            print(addTaskViewModel.taskName)
        }
    }
}

#Preview {
    let repository = AddTaskRepositoryImpl()
    let useCase = AddTaskUseCaseImpl(repository: repository)
    let viewModel = AddTaskViewModel(useCase: useCase)
    
    return AddTaskPrioritizationView(addTaskViewModel: viewModel, onDismiss: { })
}


extension AddTaskPrioritizationView {
    var prioritizeTitle: some View {
        TitleView(text: "Let's prioritize your task")
            .padding(.bottom)
    }
    
    var urgencyParameterSelection: some View {
        VStack(alignment: .leading) {
            TitleParameterTaskView(title: "Urgency",
                                   information: "How quick this task needs to be completed?")
            
            HStack(spacing: 90) {
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
        VStack(alignment: .leading) {
            TitleParameterTaskView(title: "Difficulty",
                                   information: "How challenging is this task for you?")
            
            HStack(spacing: 90) {
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
        VStack(alignment: .leading) {
            TitleParameterTaskView(title: "Fun",
                                   information: "How fun is this task for you?")

            HStack(spacing: 90) {
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
        LinearGradient(colors: addTaskViewModel.whiteGradient, startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea(edges: .top)
            .frame(height: 90)
            .overlay(alignment: .top) {
                Text("New Task")
                    .font(.oswaldTitle1)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Button {
                            coordinator.isShowAddTaskPrioritization.toggle()
                        } label: {
                            Circle()
                        }
                        .buttonStyle(CustomCircleButtonStyle(systemName: "chevron.left"))
                    }
                    .padding(.horizontal, 38)
            }
    }
    
    var confirmButton: some View {
        LinearGradient(colors: addTaskViewModel.whiteGradient, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 90)
            .overlay {
                Button {
                    addTaskViewModel.addNewTask()
                    addTaskViewModel.audioManager.playAudioPlayerOne(.created)
                    coordinator.isShowAddTaskPrioritization.toggle()
                    onDismiss()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark")
                            .fontWeight(.semibold)

                        Text("Add New Task")
                    }
                }
                .buttonStyle(CallToActionButtonStyle())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 10)
            }
    }
}
