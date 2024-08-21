//
//  CustomCircleButtonStyle.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct CustomCircleButtonStyle: ButtonStyle {
    let systemName: String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .frame(width: 36, height: 36)
            .overlay {
                Image(systemName: systemName)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)

            }
            .opacity(configuration.isPressed ? 0.25 : 1)
    }
}
