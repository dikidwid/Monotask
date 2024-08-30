//
//  SwiftDataContextManager.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import SwiftData

public class SwiftDataContextManager {
    public static var shared = SwiftDataContextManager()
    var container: ModelContainer
    var context: ModelContext?

    init() {
        do {
            let configurations = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(for: TaskLocalEntity.self,
                                           RewardLocalEntity.self
                                           , configurations: configurations)
            context = ModelContext(container)
        } catch {
            fatalError("Error initializing database container: \(error)")
        }
    }
}
