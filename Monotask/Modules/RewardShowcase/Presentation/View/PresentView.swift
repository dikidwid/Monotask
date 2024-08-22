//
//  PresentView.swift
//  Monotask
//
//  Created by Felicia Himawan on 19/08/24.
//

import SwiftUI

struct PresentView: View {
    let rewardImage: String
    let rewardName: String
    let rewardMessage: String

    let onDismiss: (() -> Void)
    
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Image("\(rewardImage)")
                .ignoresSafeArea(edges: .bottom)
            
            VStack {
                Text("Hooray!, you got")
                    .font(.oswaldLargeTitle)
                    .foregroundColor(.white)
                
                Text(" \"\(rewardName)\"")
                    .font(.oswaldLargeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                Text(rewardMessage)
                    .font(.oswaldBody)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 60)
                
                Spacer()
            }
            .padding(.top, 95)
        }
        .onTapGesture {
            onDismiss()
        }
        .onAppear { AudioManager.shared.playSoundEffectTwo(.presented, volume: 0.2) }
    }
    
}

#Preview {
    PresentView(rewardImage: "artStarPreview", rewardName: "The Angel", rewardMessage: "Completing tasks can be a real challenge, but you powered through and made it happen.", onDismiss: {})
}
