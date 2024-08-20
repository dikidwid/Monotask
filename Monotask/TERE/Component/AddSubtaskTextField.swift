//
//  AddSubtaskTextField.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct AddSubtaskTextField: View {
    @Binding var subtask: String
    var placeholder: String
    var onCommit: () -> Void // Closure untuk menangani commit

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            TextField(placeholder, text: $subtask, onCommit: {
                onCommit()
            })
            
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: "arrow.up")
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .frame(width: 30, height: 30, alignment: .center)
            .background(Color(red: 0.78, green: 0.78, blue: 0.8))
            .cornerRadius(18)
            .onTapGesture {
                onCommit() 
            }
        }
        .font(.oswaldBody)
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

