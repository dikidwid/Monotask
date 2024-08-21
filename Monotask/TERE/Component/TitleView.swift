//
//  TitleComponent.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct TitleView: View {
    var text: String
    var font: Font = .oswaldTitle2
    var color: Color = .black
    var weight: Font.Weight = .regular

    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(color)
            .fontWeight(weight)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TitleView(text: "Prioritize Your Task")
}

