//
//  ArtWaterView.swift
//  Monotask
//
//  Created by Felicia Himawan on 22/08/24.
//

import SwiftUI
import SVGView

struct ArtWaterView: View {
    @State private var personAnimationTimer: Timer?
    @State private var yOffset: CGFloat = 0
    @State private var yDirection: CGFloat = 1
    
    @State private var flowerAnimationTimer: Timer?
    @State private var flowerScale: CGFloat = 1.0
    @State private var flowerScaleDirection: CGFloat = 1.0
    
    var body: some View {
        VStack {
            svgView
        }
    }
    
    var svgView: some View {
            let view = SVGView(contentsOf: Bundle.main.url(forResource: "artWaterFlower", withExtension: "svg")!)
            
            if let personVector = view.getNode(byId: "personWaterVector") {
                startSmoothOscillation(for: personVector)
            }
            
            if let starVector = view.getNode(byId: "flowerVector") {
                startSmoothScaleAnimation(for: starVector)
            }
            
            
            return view
        }
    
    func startSmoothOscillation(for part: SVGNode) {
            personAnimationTimer?.invalidate()
            
            personAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.yOffset += self.yDirection * 0.01
                
                if self.yOffset >= 0 {
                    self.yDirection = -1
                } else if self.yOffset <= -2 {
                    self.yDirection = 1
                }
                
                withAnimation(Animation.linear(duration: 0.01)) {
                    
                    part.transform = CGAffineTransform(rotationAngle: self.yOffset * .pi / 180)
                }
            }
        }
        
    func startSmoothScaleAnimation(for part: SVGNode) {
           flowerAnimationTimer?.invalidate()
           
           flowerAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
               self.flowerScale += self.flowerScaleDirection * 0.0005
               
               if self.flowerScale >= 1.0 {
                   self.flowerScaleDirection = -1
               } else if self.flowerScale <= 0.9 {
                   self.flowerScaleDirection = 1
               }
               
               let centerX = part.bounds().midX
               let centerY = part.bounds().midY
               
               let transform = CGAffineTransform(translationX: centerX, y: centerY)
                   .scaledBy(x: self.flowerScale, y: self.flowerScale)
                   .translatedBy(x: -centerX, y: -centerY)
               
               withAnimation(Animation.linear(duration: 0.01)) {
                   part.transform = transform
               }
           }
       }
    
}

#Preview {
    ArtWaterView()
}
