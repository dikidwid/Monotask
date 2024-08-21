//
//  AppCoordinator.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    let taskListCoordinator: TaskListCoordinator = TaskListCoordinator()
    let rewardListCoordinator: RewardShowcaseCoordinator = RewardShowcaseCoordinator()
    @Published var addTaskCoordinator: AddTaskCoordinator = AddTaskCoordinator()
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: AppSheet?
    @Published var fullScreenCover: AppFullScreenCover?
    
    // MARK: - Navigation functions
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func present(_ sheet: AppSheet) {
        self.sheet = sheet
    }
    
    func fullScreenCover(_ fullScreenCover: AppFullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        sheet = nil
    }
    
    func dismissFullScreenOver() {
        fullScreenCover = nil
    }

    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: AppScreen) -> some View {
        switch screen {
        case .taskList:
            taskListCoordinator.makeTaskListView()
        case .showcaseJourney:
            rewardListCoordinator.makeView()
        }
    }
    
    @ViewBuilder
    func build(_ sheet: AppSheet) -> some View {
        switch sheet {
        case .detailTask:
            Text("Detail Task")
        }
    }
    
    @ViewBuilder
    func build(_ fullScreenCover: AppFullScreenCover) -> some View {
        switch fullScreenCover {
        case .addTaskDetail(let onDismiss):
            AddTaskCoordinatorView(coordinator: self.addTaskCoordinator, onDismiss: onDismiss)
        }
    }
}
