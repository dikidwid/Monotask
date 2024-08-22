//
//  DetailTaskCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 22/08/24.
//

import Foundation

public final class DetailTaskCoordinator {
    func makeDetailTaskView(task: TaskModel, appCoordinator: AppCoordinator, onDismiss: @escaping (() -> Void)) -> DetailTaskViewControllerRepresentable {
        let repository = DetailTaskRepositoryImpl()
        let useCase = DetailTaskUseCaseImpl(repository: repository)
        let viewModel = DetailTaskViewModel(task: task, useCase: useCase, appCoordinator: appCoordinator)
        let view = DetailTaskViewControllerRepresentable(detailTaskViewModel: viewModel, onDismiss: onDismiss)
        
        return view
    }
}
