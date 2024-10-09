//
//  AppPresentationStyle.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

enum AppScreen: Identifiable {
    case taskList
    case showcaseJourney
    
    var id: Self { return self }
}

enum AppSheet: Identifiable {
    case detailTask(task: TaskModel, onDismiss: ((TaskModel?) -> Void))
    
    var id: Self { return self }
}

enum AppFullScreenCover: Identifiable {
    case addTaskDetail(onDismiss: ((TaskModel) -> Void))
    case editTaskDetail(taskID: String, onDismiss: ((TaskModel) -> Void))
    
    var id: Self { return self }
}

//MARK: - Conformance to Hashable and Equateable Protocol for the closure
extension AppSheet: Hashable {
    static func == (lhs: AppSheet, rhs: AppSheet) -> Bool {
        switch(lhs, rhs) {
        case (.detailTask, .detailTask):
            return true
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .detailTask:
            hasher.combine("detailTask")
        }
    }
}

extension AppFullScreenCover: Hashable {
    static func == (lhs: AppFullScreenCover, rhs: AppFullScreenCover) -> Bool {
        switch(lhs, rhs) {
        case (.addTaskDetail, .addTaskDetail):
            return true
        case (.editTaskDetail, .editTaskDetail):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .addTaskDetail:
            hasher.combine("addTaskDetail")
        case .editTaskDetail:
            hasher.combine("updateTaskDetail")
        }
    }
}
