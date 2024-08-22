//
//  PresentView.swift
//  Monotask
//
//  Created by Felicia Himawan on 19/08/24.
//

import SwiftUI

struct PresentView: View {
    @Binding var showPresent: Bool
    
    let artImage: String
    let artName: String
    
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Image("\(artImage)")
            //                            .resizable()
            //                            .scaledToFill()
                .ignoresSafeArea(edges: .bottom)
            
            VStack{
                Text("Hooray, you got")
                    .font(.oswaldLargeTitle)
                    .foregroundColor(.white)
                
                Text(" \"\(artName)\"")
                    .font(.oswaldLargeTitle)
                    .foregroundColor(.white)
                
                Text("Completing tasks can be a real challenge, but\nyou powered through and made it happen.")
                    .font(.oswaldBody)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.top, 95)
        }
        .onTapGesture {
            showPresent = false
        }
    }
    
}
//
//#Preview {
//    PresentView(showPresent: .constant(true))
//}
