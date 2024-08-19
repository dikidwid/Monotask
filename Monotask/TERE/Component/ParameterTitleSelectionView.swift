//
//  ParameterSelectionView.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct ParameterTitleSelectionView: View {
    var text: String
    var font: Font = .oswaldCallout
    var color: Color = .black
    var weight: Font.Weight = .regular

    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(color)
            .fontWeight(weight)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 60)
    }
}

#Preview {
    ParameterTitleSelectionView(text: "Difficulty Level")
}


