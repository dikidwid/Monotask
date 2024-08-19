//
//  ContentView.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct CreateTaskView: View {
    @StateObject private var viewModel = CreateTaskViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    TitleView(text: "Task Title")
                    TaskTitleTextField(tasktitle: $viewModel.task.title, placeholder: "Brain dump your task...") {
                        print(viewModel.task.title)
                    }
                    .padding(.leading, 0)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                
                VStack(alignment: .leading, spacing: 8) {
                    TitleView(text: "Add Subtask")
                    if !viewModel.task.subtasks.isEmpty {
                        ForEach(viewModel.task.subtasks) { subtask in
                            Text(subtask.title)
                                .padding(.vertical, 2)
                                .padding(.leading, 50)
                        }
                    }
                    AddSubtaskTextField(subtask: $viewModel.newSubtask, placeholder: "Break down your task here...") {
                        print(viewModel.newSubtask)
                        viewModel.addSubtask()
                    }
                    .padding(.leading, 40)
                }
                
                Spacer()
                Spacer()
                
                VStack {
                    HStack {
                        TitleView(text: "Add Reminder")
                        Spacer()
                        Toggle("", isOn: $viewModel.task.isReminderOn)
                            .toggleStyle(SwitchToggleStyle(tint: .yellow))
                            .labelsHidden()
                            .padding()
                    }
                    .padding(.leading, 0)
                    
                    if viewModel.task.isReminderOn {
                        VStack {
                            DatePicker(
                                "",
                                selection: Binding(
                                    get: { viewModel.task.reminderDate ?? Date() },
                                    set: { viewModel.updateReminderDate($0) }
                                ),
                                displayedComponents: [.hourAndMinute]
                            )
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                            .padding()
                            .onChange(of: viewModel.task.reminderDate) { newDate in
                                let formatter = DateFormatter()
                                formatter.timeStyle = .short
                                if let date = newDate {
                                    print("Selected reminder time: \(formatter.string(from: date))")
                                }
                            }
                        }
                    }
                }
                NavigationLink(destination: CreateTaskView2()) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Continue")
                    }
                }
                .buttonStyle(CallToActionButtonStyle())
            }
        }
    }
}

#Preview{
    CreateTaskView()
}
