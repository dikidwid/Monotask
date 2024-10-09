//
//  CallToActionButtonStyle.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 16/08/24.
//

import SwiftUI

struct CallToActionButtonStyle: ButtonStyle {
    let isDisable: Bool
    
    init(isDisable: Bool = false) {
        self.isDisable = isDisable
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.oswaldTitle2)
            .foregroundStyle(isDisable ? Color(uiColor: .systemGray2): .black)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(isDisable ? Color(uiColor: .systemGray5) : Color.appAccentColor )
            .cornerRadius(30)
            .opacity(configuration.isPressed ? 0.25 : 1)
            .padding(.bottom, 47)
    }
}
