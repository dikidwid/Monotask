//
//  BackButtonStyle.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import SwiftUI

struct BackButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.oswaldTitle2)
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(.black)
            .cornerRadius(30)
            .opacity(configuration.isPressed ? 0.25 : 1)
            .padding(.bottom, 47)
    }
}
