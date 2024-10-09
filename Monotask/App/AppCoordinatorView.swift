//
//  AppCoordinatorView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator: AppCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.taskList)
                .navigationDestination(for: AppScreen.self) { page in
                    appCoordinator.build(page)
                }
                .sheet(item: $appCoordinator.sheet) { sheet in
                    appCoordinator.build(sheet)
                }
                .fullScreenCover(item: $appCoordinator.fullScreenCover) { fullScreenCover in
                    appCoordinator.build(fullScreenCover)
                }
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    AppCoordinatorView()
}
