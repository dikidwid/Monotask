//
//  UnlockedView.swift
//  Monotask
//
//  Created by Felicia Himawan on 20/08/24.
//

import SwiftUI
import SVGView

struct UnlockedView: View {
    @State private var isAnimating = false
    @State private var isShaking = false
    
    
    var body: some View {
        ZStack{
            shineSVG
                .frame(width: 280)
                .blur(radius: 8)
                .scaleEffect(isAnimating ? 1.1 : 1.0) // Scale up to 110% and back to 100%
                .animation(
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true), // Repeats the animation forever
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true // Start animation when the view appears
                }
            
            unlockSVG
                .frame(width: 95, height: 120)
                .padding(.top)
                .rotationEffect(.degrees(isShaking ? -5 : 5))
                                .offset(x: isShaking ? -5 : 5)
                                .animation(
                                    Animation.easeInOut(duration: 1)
                                        .repeatForever(autoreverses: true),
                                    value: isShaking
                                )
                                .onAppear {
                                    isShaking = true // Start shaking when the view appears
                                }
            
        }
    }
    
    var unlockSVG: some View{
        let view = SVGView(contentsOf: Bundle.main.url(forResource: "unlockVector", withExtension: "svg")!)
        
        return view
    }
    
    var shineSVG: some View{
        let view = SVGView(contentsOf: Bundle.main.url(forResource: "shineLockVector", withExtension: "svg")!)
        
        return view
    }
}

#Preview {
    UnlockedView()
}
