//
//  ArtView.swift
//  Monotask
//
//  Created by Felicia Himawan on 18/08/24.
//
import SwiftUI
import SVGView

struct ArtStarView: View {
    @State private var personAnimationTimer: Timer?
    @State private var yOffset: CGFloat = 0
    @State private var yDirection: CGFloat = 1
    
    @State private var starAnimationTimer: Timer?
    @State private var starOpacity: CGFloat = 1.0
    
    var body: some View {
        VStack {
            svgView
        }
    }
    
    var svgView: some View {
        let view = SVGView(contentsOf: Bundle.main.url(forResource: "art", withExtension: "svg")!)
        
        if let personVector = view.getNode(byId: "personVector") {
            startSmoothOscillation(for: personVector)
        }
        
        if let starVector = view.getNode(byId: "starVector") {
            startOpacityAnimation(for: starVector)
        }
        
        return view
    }
    
    func startSmoothOscillation(for part: SVGNode) {
        personAnimationTimer?.invalidate()
        
        personAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.yOffset += self.yDirection * 0.02
            
            if self.yOffset >= 3 {
                self.yDirection = -1
            } else if self.yOffset <= -3 {
                self.yDirection = 1
            }
            
            withAnimation(Animation.linear(duration: 0.01)) {
                part.transform = CGAffineTransform(translationX: 0, y: self.yOffset)
            }
        }
    }
    
    func startOpacityAnimation(for part: SVGNode) {
            starAnimationTimer?.invalidate()

        starAnimationTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                self.starOpacity = self.starOpacity == 1.0 ? 0.5 : 1.0

            withAnimation(Animation.linear(duration: 2.5)) {
                    part.opacity = self.starOpacity
                }
            }
        }
}

#Preview {
    ArtStarView()
}
