//
//  TaskParamterView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import SwiftUI

struct TitleParameterTaskView: View {
    let title: String
    let information: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.oswaldTitle3)
            
            Text(information)
                .font(.oswaldSubhead)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 20)
    }
}
