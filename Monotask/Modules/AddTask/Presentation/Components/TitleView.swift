//
//  TitleComponent.swift
//  addTask
//
//  Created by Theresia Angela Ayrin on 16/08/24.
//

import SwiftUI

struct TitleView: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.oswaldTitle2)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TitleView(text: "Prioritize Your Task")
}

