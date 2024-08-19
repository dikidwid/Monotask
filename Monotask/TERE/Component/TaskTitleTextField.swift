//
//  TaskTitleTextField.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct TaskTitleTextField: View {
    @Binding var tasktitle: String
    var placeholder: String
    var onCommit: () -> Void // Closure untuk menangani commit

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            TextField(placeholder, text: $tasktitle, onCommit: {
                onCommit() // Panggil closure saat Enter ditekan
            })
        }
        .padding(.horizontal, 11)
        .padding(.vertical, 24)
        .frame(width: 316, height: 44, alignment: .leading)
        .cornerRadius(10)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .inset(by: 0.5)
            .stroke(Color(red: 0.68, green: 0.68, blue: 0.7), lineWidth: 1)
        )
    }
}
