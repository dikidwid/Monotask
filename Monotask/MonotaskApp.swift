//
//  MonotaskApp.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import SwiftUI

@main
struct MonotaskApp: App {
    let taskListCoordinator = TaskListCoordinator()

    var body: some Scene {
        WindowGroup {
            taskListCoordinator.makeTaskListView()
        }
    }
}
