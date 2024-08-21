//
//  ArtView.swift
//  Monotask
//
//  Created by Felicia Himawan on 18/08/24.
//
import SwiftUI
import SVGView

struct ArtView: View {
    @State private var personAnimationTimer: Timer?
    @State private var bottomLeftAnimationTimer: Timer?
    @State private var yOffset: CGFloat = 0
    @State private var xOffset: CGFloat = 0
    @State private var yDirection: CGFloat = 1 // Direction for vertical movement
    @State private var xDirection: CGFloat = -1 // Direction for horizontal movement (initially leftward)
    
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
        
        //        if let bottomLeftGroup = view.getNode(byId: "bottomLeftGroup") {
        //            startBottomLeftAnimation(for: bottomLeftGroup)
        //        }
        
        return view
    }
    
    func startSmoothOscillation(for part: SVGNode) {
        // Invalidate any existing timer for person animation
        personAnimationTimer?.invalidate()
        
        // Set up a new timer for the person animation
        personAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            // Adjust the yOffset value incrementally
            self.yOffset += self.yDirection * 0.02
            
            // Reverse direction when reaching the bounds (-2 to 2)
            if self.yOffset >= 3 {
                self.yDirection = -1
            } else if self.yOffset <= -3 {
                self.yDirection = 1
            }
            
            // Apply the yOffset to the part's transform using CGAffineTransform
            withAnimation(Animation.linear(duration: 0.01)) {
                part.transform = CGAffineTransform(translationX: 0, y: self.yOffset)
            }
        }
    }
    
    func startOpacityAnimation(for part: SVGNode) {
            // Invalidate any existing timer for star animation
            starAnimationTimer?.invalidate()

            // Set up a new timer for the star opacity animation
        starAnimationTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                // Toggle between 0.2 and 1 for opacity
                self.starOpacity = self.starOpacity == 1.0 ? 0.5 : 1.0

                // Apply the opacity change with animation
            withAnimation(Animation.linear(duration: 2.5)) {
                    part.opacity = self.starOpacity
                }
            }
        }
    
    //    func startBottomLeftAnimation(for part: SVGNode) {
    //        // Invalidate any existing timer
    //        bottomLeftAnimationTimer?.invalidate()
    //        self.xOffset = 0
    //        self.xDirection = -1 // Move left initially
    //
    //        // Set up a new timer to create a smooth oscillation
    //        bottomLeftAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
    //            // Adjust the xOffset value incrementally
    //            self.xOffset += self.xDirection * 0.02
    //
    //            // Reverse direction when reaching the bounds (0 to -2)
    //            if self.xOffset <= -2 {
    //                self.xDirection = 1 // Start moving right
    //            } else if self.xOffset >= 0 {
    //                self.xDirection = -1 // Start moving left
    //            }
    //
    //            // Apply the xOffset to the part's transform using CGAffineTransform
    //            withAnimation(Animation.linear(duration: 0.01)) {
    //                part.transform = CGAffineTransform(translationX: self.xOffset, y: 0)
    //            }
    //        }
    //    }
}

#Preview {
    ArtView()
}
