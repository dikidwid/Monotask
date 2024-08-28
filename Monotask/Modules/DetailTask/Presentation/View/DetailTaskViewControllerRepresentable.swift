//
//  DetailTaskViewControllerRepresentable.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import SwiftUI

struct DetailTaskViewControllerRepresentable: UIViewControllerRepresentable {
    
    @StateObject var detailTaskViewModel: DetailTaskViewModel
    let onDismiss: ((TaskModel?) -> Void)

    
    final class Coordinator: NSObject, DetailTaskViewControllerDelegate {
        let parent: DetailTaskViewControllerRepresentable
        
        init(_ parent: DetailTaskViewControllerRepresentable) {
            self.parent = parent
        }
        
        func didDeleteButtonTapped(task: TaskModel) {
            parent.detailTaskViewModel.deleteTask(task)
            parent.onDismiss(nil)
        }
        
        func didCloseButtonTapped() {
            // Dismiss DetailTaskViewControllerRepresentable
            parent.detailTaskViewModel.dismissDetailTask()
        }
        
        func didEditTaskbuttonTapped() {
            // Show EditTaskView
            parent.detailTaskViewModel.showUpdateTask(onDismiss: { self.parent.onDismiss($0) } )
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let detailTaskViewController = DetailTaskViewController(task: detailTaskViewModel.task)
        detailTaskViewController.delegate = context.coordinator
        
        return detailTaskViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    
}

#Preview {
    let repository = DetailTaskRepositoryImpl()
    let useCase = DetailTaskUseCaseImpl(repository: repository)
    let task = TaskModel(id: "", taskName: "Implementing Clean Architecture",
                         isCompleted: false,
                         subtasks: ["Satu dua tiga empat lima enam tujuh delapan", 
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                                    "enam tujuh delapan enam tujuh delapan enam tujuh delapan",
                            ],
                         reminderTime: .now,
                         urgencyMetric: .notUrgent,
                         difficultyMetric: .easy,
                         interestMetric: .notFun)
    let viewModel = DetailTaskViewModel(task: task, useCase: useCase, appCoordinator: AppCoordinator())
        
    return DetailTaskViewControllerRepresentable(detailTaskViewModel: viewModel, onDismiss: { _ in  print("hehe") })
}
