//
//  DetailTaskRepositoryImpl.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 22/08/24.
//

import SwiftData
import Foundation

struct DetailTaskRepositoryImpl: DetailTaskRepository {
    
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor
    func deleteTask(_ taskID: String) {
        do {
            let tasks = try self.container.mainContext.fetch(FetchDescriptor<TaskLocalEntity>())
            if let task = tasks.first(where: { $0.id == taskID }) {
                container.mainContext.delete(task)
                try container.mainContext.save()
            }
           
        } catch {
            fatalError("Error deleting on SwiftDataManager")
        }
    }
}
