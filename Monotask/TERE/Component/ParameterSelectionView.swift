//
//  ParameterSelectionView.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct ParameterSelectionView: View {
    var iconName: String
    var text: String
    var iconColor: Color = .yellow
    var textColor: Color = .primary
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(isSelected ? iconColor : .gray)
            Text(text)
                .foregroundColor(isSelected ? textColor : .gray)
            Spacer()
        }
        .padding()
        .onTapGesture {
            action()
        }
    }
}
