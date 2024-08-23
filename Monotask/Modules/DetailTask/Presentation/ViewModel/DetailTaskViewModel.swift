//
//  DetailTaskViewModel.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

class DetailTaskViewModel: ObservableObject {
    
    @Published var task: TaskModel
    
    let useCase: DetailTaskUseCase
    let coordinator: AppCoordinator
    
    init(task: TaskModel, useCase: DetailTaskUseCase, appCoordinator: AppCoordinator) {
        self.task = task
        self.useCase = useCase
        self.coordinator = appCoordinator
    }
    
    func deleteTask(_ task: TaskModel) {
        useCase.deleteTask(task)
        dismissDetailTask()
    }
    
    func dismissDetailTask() {
        coordinator.dismissSheet()
    }
    
    func showUpdateTask(onDismiss: @escaping (() -> Void)) {
        // Coordinator for UpdateTask
//        coordinator.fullScreenCover(.addTaskDetail(onDismiss: onDismiss))
    }
}
