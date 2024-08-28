//
//  CustomNavigationBar.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import SwiftUI

struct CustomAddTaskNavigationBar: View {
    let navigationTitle: String
    let onTapped: (() -> Void)
    
    var body: some View {
        LinearGradient(colors: [.clear, .white.opacity(1), .white.opacity(1)], startPoint: .bottom, endPoint: .top)
        .ignoresSafeArea(edges: .top)
        .frame(height: 90)
            .overlay(alignment: .top) {
                Text(navigationTitle)
                    .font(.oswaldTitle1)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Button {
                            onTapped()
                        } label: {
                            Circle()
                        }
                        .buttonStyle(CustomCircleButtonStyle(systemName: "chevron.left"))
                    }
                    .padding(.horizontal, 38)
                    .padding(.top, 24)
            }
    }
}
