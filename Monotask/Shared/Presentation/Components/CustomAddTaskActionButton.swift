//
//  CustomActionButton.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 28/08/24.
//

import SwiftUI

struct CustomAddTaskActionButton: View {
    let name: String
    let icon: String
    let isTaskNameFieldEmpty: Bool
    let onTapped: (() -> Void)
    
    var body: some View {
        LinearGradient(colors: [.clear, .white.opacity(1), .white.opacity(1)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 90)
            .overlay {
                Button {
                   onTapped()
                } label: {
                    HStack(spacing: 10) {
                        Text(name)
                        
                        Image(systemName: icon)
                    }
                    .padding(.horizontal, 5)
                }
                .buttonStyle(CallToActionButtonStyle(isDisable: isTaskNameFieldEmpty))
                .disabled(isTaskNameFieldEmpty)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
    }
}
