//
//  EditTaskView2.swift
//  Monotask
//
//  Created by Theresia Angela Ayrin on 20/08/24.
//

import SwiftUI

struct EditTaskView2: View {
    @ObservedObject var viewModel: EditTaskViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                TitleView(text: "Prioritize Your Task")
                
                VStack {
                    ParameterTitleSelectionView(text: "Urgency")
                    HStack {
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "I'll Wait",
                            isSelected: viewModel.task.urgency == .illWait,
                            action: {
                                viewModel.task.urgency = .illWait
                            }
                        )
                        
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Act Soon",
                            isSelected: viewModel.task.urgency == .actSoon,
                            action: {
                                viewModel.task.urgency = .actSoon
                            }
                        )
                        
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "ASAP!",
                            isSelected: viewModel.task.urgency == .asap,
                            action: {
                                viewModel.task.urgency = .asap
                            }
                        )
                    }
                }
                .padding(.leading, -20)
                
                VStack {
                    ParameterTitleSelectionView(text: "Difficulty Level")
                    HStack {
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Simple",
                            isSelected: viewModel.task.difficulty == .simple,
                            action: {
                                viewModel.task.difficulty = .simple
                            }
                        )
                        
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Challenging",
                            isSelected: viewModel.task.difficulty == .challenging,
                            action: {
                                viewModel.task.difficulty = .challenging
                            }
                        )
                        
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Intense",
                            isSelected: viewModel.task.difficulty == .intense,
                            action: {
                                viewModel.task.difficulty = .intense
                            }
                        )
                    }
                }
                .padding(.leading, -20)
                
                VStack {
                    ParameterTitleSelectionView(text: "Interest")
                    HStack {
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Mild",
                            isSelected: viewModel.task.interest == .mild,
                            action: {
                                viewModel.task.interest = .mild
                            }
                        )
                        
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Engaging",
                            isSelected: viewModel.task.interest == .engaging,
                            action: {
                                viewModel.task.interest = .engaging
                            }
                        )
                        
                        ParameterSelectionView(
                            iconName: "star.fill",
                            text: "Captivating",
                            isSelected: viewModel.task.interest == .captivating,
                            action: {
                                viewModel.task.interest = .captivating
                            }
                        )
                    }
                }
                .padding(.leading, -20)
                
                Button(action: {
                    print("Task Title: \(viewModel.task.title)")
                    print("Subtasks:")
                    for subtask in viewModel.task.subtasks {
                        print("- \(subtask.title)")
                    }
                    print("Reminder On: \(viewModel.task.isReminderOn)")
                    if let reminderDate = viewModel.task.reminderDate {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                        formatter.timeStyle = .short
                        print("Reminder Date: \(formatter.string(from: reminderDate))")
                    }
                    print("Urgency: \(viewModel.task.urgency.rawValue)")
                    print("Difficulty: \(viewModel.task.difficulty.rawValue)")
                    print("Interest: \(viewModel.task.interest.rawValue)")
                }) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Add New Task")
                    }
                }
                .buttonStyle(CallToActionButtonStyle())
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview{
    EditTaskView2(viewModel: EditTaskViewModel(task: Task(title: "Existing Task", subtasks: [Subtask(title: "Subtask 1")], isReminderOn: true, reminderDate: Date())))
}
