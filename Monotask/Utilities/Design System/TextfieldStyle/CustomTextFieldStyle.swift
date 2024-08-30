//
//  CustomTextFieldStyle.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    let isTextfieldEmpty: Bool
    let isShowSubmitButton: Bool
    let onSubmit: (()-> Void)
    
    init(isTextfieldEmpty: Bool, isShowSubmitButton: Bool, onSubmit: @escaping () -> Void = {}) {
        self.isTextfieldEmpty = isTextfieldEmpty
        self.isShowSubmitButton = isShowSubmitButton
        self.onSubmit = onSubmit
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.oswaldBody)
            .padding(.all, 12)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .fill(Color(uiColor: .systemGray2))
            }
            .overlay(alignment: .trailing) {
                if isShowSubmitButton {
                    Button {
                        onSubmit()
                    } label: {
                        Circle()
                            .fill(isTextfieldEmpty ? Color(uiColor: .systemGray3) : .appAccentColor)
                            .overlay {
                                Image(systemName: "arrow.up")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(isTextfieldEmpty ? .white : .black)
                            }
                            .padding(.vertical, 8)
                            .padding(.trailing, 10)
                            .tint(.black)
                    }
                    .disabled(isTextfieldEmpty)
                }
            }
            .autocorrectionDisabled()
    }

}
