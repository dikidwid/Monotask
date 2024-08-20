import SwiftUI

struct CreateTaskView: View {
    @ObservedObject private var viewModel = CreateTaskViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        TitleView(text: "Task Title")
                        TaskTitleTextField(tasktitle: $viewModel.task.title, placeholder: "Brain dump your task...") {
//                            print(viewModel.task.title)
                        }
                        .padding(.leading, 0)
                    }.padding(.bottom, 30)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TitleView(text: "Add Subtask")
                        if !viewModel.task.subtasks.isEmpty {
                            ForEach(viewModel.task.subtasks) { subtask in
                                
                                HStack {
                                    Image(systemName: "line.3.horizontal")
                                    
                                    Text(subtask.title)
                                        .padding(.vertical, 2)
                                        .padding(.leading, 5)
                                        .font(.oswaldBody)
                                    
                                    Spacer()
                                    
                                    Button {

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
//                            print(viewModel.newSubtask)
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
                                .onChange(of: viewModel.task.reminderDate) { newDate in
                                    let formatter = DateFormatter()
                                    formatter.timeStyle = .short
                                    if let date = newDate {
//                                        print("Selected reminder time: \(formatter.string(from: date))")
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: CreateTaskView2(viewModel: viewModel)) {
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

#Preview{
    CreateTaskView()
}
