//
//  ContentView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var taskListViewModel: TaskListViewModel
    
    var body: some View {
        NavigationStack {
            List($taskListViewModel.tasks) { $task in
                HStack {
                    Text(task.taskName)
                    
                    Spacer()
                    
                    Text(task.isCompleted ? "Completed" : "Uncompleted")
                    
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" :"xmark.circle.fill" )
                        .foregroundStyle(task.isCompleted ? .green : .red)
                }
                .onTapGesture {
                    taskListViewModel.updateTaskStatus($task)
                }
            }
            .onAppear {
                taskListViewModel.getTasks()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add New Task") {
                        taskListViewModel.addNewTask()
                    }
                }
            }
        }
    }
}

#Preview {
    let repository = TaskListRepositoryImpl()
    let useCase = TaskListUseCaseImpl(repository: repository)
    let viewModel = TaskListViewModel(useCase: useCase)
    
    return ContentView(taskListViewModel: viewModel)
}
