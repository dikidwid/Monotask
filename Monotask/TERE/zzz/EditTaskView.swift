//
//  EditTaskView.swift
//  Monotask
//
//  Created by Theresia Angela Ayrin on 20/08/24.
//

import SwiftUI

struct EditTaskView: View {
    @ObservedObject var viewModel: EditTaskViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        TitleView(text: "Task Title")
                        TaskTitleTextField(tasktitle: $viewModel.task.title, placeholder: "Brain dump your task...") {
                        }
                        .padding(.leading, 0)
                    }.padding(.bottom, 30)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TitleView(text: "Add Subtask")
                        if !viewModel.task.subtasks.isEmpty {
                            ForEach(viewModel.task.subtasks.indices, id: \.self) { index in
                                HStack {
                                    Image(systemName: "line.3.horizontal")
                                    
                                    TextField("Subtask", text: $viewModel.task.subtasks[index].title)
                                        .padding(.vertical, 2)
                                        .padding(.leading, 5)
                                        .font(.oswaldBody)
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.deleteSubtask(at: index)
                                    } label: {
                                        Image(systemName: "xmark")
                                            .fontWeight(.semibold)
                                            .tint(.black)
                                    }
                                }
                                .padding(.horizontal, 45)
                            }
                        }
                        
                        AddSubtaskTextField(subtask: $viewModel.newSubtask, placeholder: "Break down your task here...") {
                            viewModel.addSubtask()
                        }
                        .padding(.leading, 40)
                    }.padding(.bottom, 30)
                    
                    VStack {
                        HStack {
                            TitleView(text: "Add Reminder")
                            Spacer()
                            Toggle("", isOn: $viewModel.task.isReminderOn)
                                .toggleStyle(SwitchToggleStyle(tint: .yellow))
                                .labelsHidden()
                                .padding(.trailing, 40)
                        }
                        
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
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: EditTaskView2(viewModel: viewModel)) {
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
}

#Preview {
    EditTaskView(viewModel: EditTaskViewModel(task: Task(title: "Existing Task", subtasks: [SubtaskModel(title: "Subtask 1")], isReminderOn: true, reminderDate: Date())))
}
