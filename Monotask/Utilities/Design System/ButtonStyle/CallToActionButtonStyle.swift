//
//  CallToActionButtonStyle.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 16/08/24.
//

import SwiftUI

struct CallToActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.oswaldTitle2)
            .foregroundStyle(.black)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color.appAccentColor)
            .cornerRadius(30)
            .opacity(configuration.isPressed ? 0.25 : 1)
    }
}
