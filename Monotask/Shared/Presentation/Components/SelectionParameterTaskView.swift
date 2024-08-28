//
//  SymbolParameterTaskView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct SelectionParameterTaskView: View {
    let isSelected: Bool
    let enabledImage: String
    let disabledImage: String
    let description: String
    
    var body: some View {
        VStack {
            Image(isSelected ? enabledImage : disabledImage)
                .resizable()
                .frame(width: 36, height: 36)
            
            Text(description)
                .font(.oswaldCaption1)
                .foregroundStyle(isSelected ? .black : Color(uiColor: .systemGray3))
        }
        .frame(width: 54)
    }
}

