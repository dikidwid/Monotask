//
//  CheckTaskView.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 15/08/24.
//

import SwiftUI
import CoreHaptics
import AVFAudio

struct CheckTaskView: View {
    @State private var coreHapticEngine: CHHapticEngine?
    
    @State private var isPressing: Bool = false
    @State private var outerLayerScale: Double = 0
    @State private var firstInnerLayerOpacity: Double = 0
    @State private var secondInnerLayerOpacity: Double = 0
    @State private var thirdInnerLayerOpacity: Double = 0
    @State private var fourthInnerLayerOpacity: Double = 0
    
    let task: TaskModel?
    let onCheckedTask: ((Bool) -> Void?)
    let coreHapticsManager: CoreHapticsManager = CoreHapticsManager.shared
    
    private let maxScale: Double = 1.2
        
    var body: some View {
        ZStack {
            CheckTaskShape()
                .frame(width: 235, height: 235)
                .scaleEffect(outerLayerScale)
                .shadow(radius: 10)
            
            CheckTaskShape()
                .foregroundStyle(Color(hex: "454545"))
                .frame(width: 195, height: 195)
                .opacity(firstInnerLayerOpacity)
                .scaleEffect(firstInnerLayerOpacity)
                .shadow(color: .black.opacity(0.25), radius: 24, y: 4)

            CheckTaskShape()
                .foregroundStyle(Color(hex: "666666"))
                .frame(width: 155, height: 155)
                .opacity(secondInnerLayerOpacity)
                .scaleEffect(secondInnerLayerOpacity)
                .shadow(color: .black.opacity(0.25), radius: 24, y: 4)

            CheckTaskShape()
                .foregroundStyle(Color(hex: "7B7B7B"))
                .frame(width: 115, height: 115)
                .opacity(thirdInnerLayerOpacity)
                .scaleEffect(thirdInnerLayerOpacity)
                .shadow(color: .black.opacity(0.25), radius: 24, y: 4)

            CheckTaskShape()
                .foregroundStyle(Color(hex: "A0A0A0"))
                .frame(width: 75, height: 75)
                .opacity(fourthInnerLayerOpacity)
                .scaleEffect(fourthInnerLayerOpacity)
                .shadow(color: .black.opacity(0.25), radius: 24, y: 4)

        }
        .scaleEffect(isPressing ? maxScale : 1)
        .onLongPressGesture(minimumDuration: 2) {
            withAnimation(.bouncy(duration: 1)) {
                firstInnerLayerOpacity = maxScale
                secondInnerLayerOpacity = maxScale
                thirdInnerLayerOpacity = maxScale
                fourthInnerLayerOpacity = maxScale
                outerLayerScale = maxScale
                onCheckedTask(true)
                coreHapticsManager.playHapticsFile(named: "Sparkle")
                coreHapticsManager.playHapticsFile(named: "Gravel")
            }
        } onPressingChanged: { isPressing in
            if isPressing {
                withAnimation(.bouncy) {
                    self.isPressing = true
                }
                withAnimation(.easeIn(duration: 0.1).speed(0.5)) {
                    firstInnerLayerOpacity = 1
                }
                withAnimation(.easeIn(duration: 0.3).speed(0.5)) {
                    secondInnerLayerOpacity = 1
                }
                withAnimation(.easeIn(duration: 0.5).speed(0.5)) {
                    thirdInnerLayerOpacity = 1
                }
                withAnimation(.easeIn(duration: 0.7).speed(0.5)) {
                    fourthInnerLayerOpacity = 1
                }
                coreHapticsManager.playHapticsFile(named: "Transition")
            } else {
                withAnimation(.bouncy) {
                    self.isPressing = false
                }
                withAnimation(.interactiveSpring(duration: 1)) {
                    outerLayerScale = 1
                }
                withAnimation(.easeOut(duration: 1)) {
                    firstInnerLayerOpacity = 0
                }
                withAnimation(.easeOut(duration: 1)) {
                    secondInnerLayerOpacity = 0
                }
                withAnimation(.easeOut(duration: 1)) {
                    thirdInnerLayerOpacity = 0
                }
                withAnimation(.easeOut(duration: 1)) {
                    fourthInnerLayerOpacity = 0
                }
                onCheckedTask(false)
                coreHapticsManager.cancelHaptics()
            }
        }
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: isPressing)
        .onChange(of: task) {
            guard let task = task else { return }
            if task.isCompleted {
                withAnimation(.interpolatingSpring) {
                    firstInnerLayerOpacity = maxScale
                    secondInnerLayerOpacity = maxScale
                    thirdInnerLayerOpacity = maxScale
                    fourthInnerLayerOpacity = maxScale
                    outerLayerScale = maxScale
                }
            } else {
                withAnimation(.interpolatingSpring) {
                    firstInnerLayerOpacity = 0
                    secondInnerLayerOpacity = 0
                    thirdInnerLayerOpacity = 0
                    fourthInnerLayerOpacity = 0
                    outerLayerScale = 1
                }
            }
        }
    }
}

struct CheckTaskShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.43792*width, y: 0.11697*height))
        path.addCurve(to: CGPoint(x: 0.56208*width, y: 0.11697*height), control1: CGPoint(x: 0.46598*width, y: 0.07132*height), control2: CGPoint(x: 0.53402*width, y: 0.07132*height))
        path.addLine(to: CGPoint(x: 0.56734*width, y: 0.12553*height))
        path.addCurve(to: CGPoint(x: 0.66305*width, y: 0.15574*height), control1: CGPoint(x: 0.58697*width, y: 0.15746*height), control2: CGPoint(x: 0.62786*width, y: 0.17037*height))
        path.addLine(to: CGPoint(x: 0.6726*width, y: 0.15176*height))
        path.addCurve(to: CGPoint(x: 0.77306*width, y: 0.22284*height), control1: CGPoint(x: 0.72298*width, y: 0.13081*height), control2: CGPoint(x: 0.7781*width, y: 0.16981*height))
        path.addLine(to: CGPoint(x: 0.7722*width, y: 0.2319*height))
        path.addCurve(to: CGPoint(x: 0.83152*width, y: 0.31122*height), control1: CGPoint(x: 0.76867*width, y: 0.26907*height), control2: CGPoint(x: 0.79406*width, y: 0.30302*height))
        path.addLine(to: CGPoint(x: 0.84086*width, y: 0.31326*height))
        path.addCurve(to: CGPoint(x: 0.87924*width, y: 0.42828*height), control1: CGPoint(x: 0.89445*width, y: 0.32499*height), control2: CGPoint(x: 0.91555*width, y: 0.38822*height))
        path.addLine(to: CGPoint(x: 0.87333*width, y: 0.4348*height))
        path.addCurve(to: CGPoint(x: 0.87333*width, y: 0.53302*height), control1: CGPoint(x: 0.84789*width, y: 0.46287*height), control2: CGPoint(x: 0.84789*width, y: 0.50495*height))
        path.addLine(to: CGPoint(x: 0.87924*width, y: 0.53954*height))
        path.addCurve(to: CGPoint(x: 0.84086*width, y: 0.65456*height), control1: CGPoint(x: 0.91555*width, y: 0.5796*height), control2: CGPoint(x: 0.89445*width, y: 0.64283*height))
        path.addLine(to: CGPoint(x: 0.83152*width, y: 0.6566*height))
        path.addCurve(to: CGPoint(x: 0.7722*width, y: 0.73592*height), control1: CGPoint(x: 0.79406*width, y: 0.6648*height), control2: CGPoint(x: 0.76867*width, y: 0.69875*height))
        path.addLine(to: CGPoint(x: 0.77306*width, y: 0.74498*height))
        path.addCurve(to: CGPoint(x: 0.6726*width, y: 0.81606*height), control1: CGPoint(x: 0.7781*width, y: 0.79801*height), control2: CGPoint(x: 0.72298*width, y: 0.83701*height))
        path.addLine(to: CGPoint(x: 0.66305*width, y: 0.81208*height))
        path.addCurve(to: CGPoint(x: 0.56734*width, y: 0.84229*height), control1: CGPoint(x: 0.62786*width, y: 0.79745*height), control2: CGPoint(x: 0.58697*width, y: 0.81036*height))
        path.addLine(to: CGPoint(x: 0.56208*width, y: 0.85085*height))
        path.addCurve(to: CGPoint(x: 0.43792*width, y: 0.85085*height), control1: CGPoint(x: 0.53402*width, y: 0.89651*height), control2: CGPoint(x: 0.46598*width, y: 0.89651*height))
        path.addLine(to: CGPoint(x: 0.43266*width, y: 0.84229*height))
        path.addCurve(to: CGPoint(x: 0.33695*width, y: 0.81208*height), control1: CGPoint(x: 0.41303*width, y: 0.81036*height), control2: CGPoint(x: 0.37214*width, y: 0.79745*height))
        path.addLine(to: CGPoint(x: 0.3274*width, y: 0.81606*height))
        path.addCurve(to: CGPoint(x: 0.22694*width, y: 0.74498*height), control1: CGPoint(x: 0.27702*width, y: 0.83701*height), control2: CGPoint(x: 0.2219*width, y: 0.79801*height))
        path.addLine(to: CGPoint(x: 0.2278*width, y: 0.73592*height))
        path.addCurve(to: CGPoint(x: 0.16847*width, y: 0.6566*height), control1: CGPoint(x: 0.23133*width, y: 0.69875*height), control2: CGPoint(x: 0.20594*width, y: 0.6648*height))
        path.addLine(to: CGPoint(x: 0.15914*width, y: 0.65456*height))
        path.addCurve(to: CGPoint(x: 0.12076*width, y: 0.53954*height), control1: CGPoint(x: 0.10555*width, y: 0.64283*height), control2: CGPoint(x: 0.08445*width, y: 0.5796*height))
        path.addLine(to: CGPoint(x: 0.12667*width, y: 0.53302*height))
        path.addCurve(to: CGPoint(x: 0.12667*width, y: 0.4348*height), control1: CGPoint(x: 0.15211*width, y: 0.50495*height), control2: CGPoint(x: 0.15211*width, y: 0.46287*height))
        path.addLine(to: CGPoint(x: 0.12076*width, y: 0.42828*height))
        path.addCurve(to: CGPoint(x: 0.15914*width, y: 0.31326*height), control1: CGPoint(x: 0.08445*width, y: 0.38822*height), control2: CGPoint(x: 0.10555*width, y: 0.32499*height))
        path.addLine(to: CGPoint(x: 0.16847*width, y: 0.31122*height))
        path.addCurve(to: CGPoint(x: 0.2278*width, y: 0.2319*height), control1: CGPoint(x: 0.20594*width, y: 0.30302*height), control2: CGPoint(x: 0.23133*width, y: 0.26907*height))
        path.addLine(to: CGPoint(x: 0.22694*width, y: 0.22284*height))
        path.addCurve(to: CGPoint(x: 0.3274*width, y: 0.15176*height), control1: CGPoint(x: 0.2219*width, y: 0.16981*height), control2: CGPoint(x: 0.27702*width, y: 0.13081*height))
        path.addLine(to: CGPoint(x: 0.33695*width, y: 0.15574*height))
        path.addCurve(to: CGPoint(x: 0.43266*width, y: 0.12553*height), control1: CGPoint(x: 0.37214*width, y: 0.17037*height), control2: CGPoint(x: 0.41303*width, y: 0.15746*height))
        path.addLine(to: CGPoint(x: 0.43792*width, y: 0.11697*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.43792*width, y: 0.11697*height))
        path.addCurve(to: CGPoint(x: 0.56208*width, y: 0.11697*height), control1: CGPoint(x: 0.46598*width, y: 0.07132*height), control2: CGPoint(x: 0.53402*width, y: 0.07132*height))
        path.addLine(to: CGPoint(x: 0.56734*width, y: 0.12553*height))
        path.addCurve(to: CGPoint(x: 0.66305*width, y: 0.15574*height), control1: CGPoint(x: 0.58697*width, y: 0.15746*height), control2: CGPoint(x: 0.62786*width, y: 0.17037*height))
        path.addLine(to: CGPoint(x: 0.6726*width, y: 0.15176*height))
        path.addCurve(to: CGPoint(x: 0.77306*width, y: 0.22284*height), control1: CGPoint(x: 0.72298*width, y: 0.13081*height), control2: CGPoint(x: 0.7781*width, y: 0.16981*height))
        path.addLine(to: CGPoint(x: 0.7722*width, y: 0.2319*height))
        path.addCurve(to: CGPoint(x: 0.83152*width, y: 0.31122*height), control1: CGPoint(x: 0.76867*width, y: 0.26907*height), control2: CGPoint(x: 0.79406*width, y: 0.30302*height))
        path.addLine(to: CGPoint(x: 0.84086*width, y: 0.31326*height))
        path.addCurve(to: CGPoint(x: 0.87924*width, y: 0.42828*height), control1: CGPoint(x: 0.89445*width, y: 0.32499*height), control2: CGPoint(x: 0.91555*width, y: 0.38822*height))
        path.addLine(to: CGPoint(x: 0.87333*width, y: 0.4348*height))
        path.addCurve(to: CGPoint(x: 0.87333*width, y: 0.53302*height), control1: CGPoint(x: 0.84789*width, y: 0.46287*height), control2: CGPoint(x: 0.84789*width, y: 0.50495*height))
        path.addLine(to: CGPoint(x: 0.87924*width, y: 0.53954*height))
        path.addCurve(to: CGPoint(x: 0.84086*width, y: 0.65456*height), control1: CGPoint(x: 0.91555*width, y: 0.5796*height), control2: CGPoint(x: 0.89445*width, y: 0.64283*height))
        path.addLine(to: CGPoint(x: 0.83152*width, y: 0.6566*height))
        path.addCurve(to: CGPoint(x: 0.7722*width, y: 0.73592*height), control1: CGPoint(x: 0.79406*width, y: 0.6648*height), control2: CGPoint(x: 0.76867*width, y: 0.69875*height))
        path.addLine(to: CGPoint(x: 0.77306*width, y: 0.74498*height))
        path.addCurve(to: CGPoint(x: 0.6726*width, y: 0.81606*height), control1: CGPoint(x: 0.7781*width, y: 0.79801*height), control2: CGPoint(x: 0.72298*width, y: 0.83701*height))
        path.addLine(to: CGPoint(x: 0.66305*width, y: 0.81208*height))
        path.addCurve(to: CGPoint(x: 0.56734*width, y: 0.84229*height), control1: CGPoint(x: 0.62786*width, y: 0.79745*height), control2: CGPoint(x: 0.58697*width, y: 0.81036*height))
        path.addLine(to: CGPoint(x: 0.56208*width, y: 0.85085*height))
        path.addCurve(to: CGPoint(x: 0.43792*width, y: 0.85085*height), control1: CGPoint(x: 0.53402*width, y: 0.89651*height), control2: CGPoint(x: 0.46598*width, y: 0.89651*height))
        path.addLine(to: CGPoint(x: 0.43266*width, y: 0.84229*height))
        path.addCurve(to: CGPoint(x: 0.33695*width, y: 0.81208*height), control1: CGPoint(x: 0.41303*width, y: 0.81036*height), control2: CGPoint(x: 0.37214*width, y: 0.79745*height))
        path.addLine(to: CGPoint(x: 0.3274*width, y: 0.81606*height))
        path.addCurve(to: CGPoint(x: 0.22694*width, y: 0.74498*height), control1: CGPoint(x: 0.27702*width, y: 0.83701*height), control2: CGPoint(x: 0.2219*width, y: 0.79801*height))
        path.addLine(to: CGPoint(x: 0.2278*width, y: 0.73592*height))
        path.addCurve(to: CGPoint(x: 0.16847*width, y: 0.6566*height), control1: CGPoint(x: 0.23133*width, y: 0.69875*height), control2: CGPoint(x: 0.20594*width, y: 0.6648*height))
        path.addLine(to: CGPoint(x: 0.15914*width, y: 0.65456*height))
        path.addCurve(to: CGPoint(x: 0.12076*width, y: 0.53954*height), control1: CGPoint(x: 0.10555*width, y: 0.64283*height), control2: CGPoint(x: 0.08445*width, y: 0.5796*height))
        path.addLine(to: CGPoint(x: 0.12667*width, y: 0.53302*height))
        path.addCurve(to: CGPoint(x: 0.12667*width, y: 0.4348*height), control1: CGPoint(x: 0.15211*width, y: 0.50495*height), control2: CGPoint(x: 0.15211*width, y: 0.46287*height))
        path.addLine(to: CGPoint(x: 0.12076*width, y: 0.42828*height))
        path.addCurve(to: CGPoint(x: 0.15914*width, y: 0.31326*height), control1: CGPoint(x: 0.08445*width, y: 0.38822*height), control2: CGPoint(x: 0.10555*width, y: 0.32499*height))
        path.addLine(to: CGPoint(x: 0.16847*width, y: 0.31122*height))
        path.addCurve(to: CGPoint(x: 0.2278*width, y: 0.2319*height), control1: CGPoint(x: 0.20594*width, y: 0.30302*height), control2: CGPoint(x: 0.23133*width, y: 0.26907*height))
        path.addLine(to: CGPoint(x: 0.22694*width, y: 0.22284*height))
        path.addCurve(to: CGPoint(x: 0.3274*width, y: 0.15176*height), control1: CGPoint(x: 0.2219*width, y: 0.16981*height), control2: CGPoint(x: 0.27702*width, y: 0.13081*height))
        path.addLine(to: CGPoint(x: 0.33695*width, y: 0.15574*height))
        path.addCurve(to: CGPoint(x: 0.43266*width, y: 0.12553*height), control1: CGPoint(x: 0.37214*width, y: 0.17037*height), control2: CGPoint(x: 0.41303*width, y: 0.15746*height))
        path.addLine(to: CGPoint(x: 0.43792*width, y: 0.11697*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.43792*width, y: 0.11697*height))
        path.addCurve(to: CGPoint(x: 0.56208*width, y: 0.11697*height), control1: CGPoint(x: 0.46598*width, y: 0.07132*height), control2: CGPoint(x: 0.53402*width, y: 0.07132*height))
        path.addLine(to: CGPoint(x: 0.56734*width, y: 0.12553*height))
        path.addCurve(to: CGPoint(x: 0.66305*width, y: 0.15574*height), control1: CGPoint(x: 0.58697*width, y: 0.15746*height), control2: CGPoint(x: 0.62786*width, y: 0.17037*height))
        path.addLine(to: CGPoint(x: 0.6726*width, y: 0.15176*height))
        path.addCurve(to: CGPoint(x: 0.77306*width, y: 0.22284*height), control1: CGPoint(x: 0.72298*width, y: 0.13081*height), control2: CGPoint(x: 0.7781*width, y: 0.16981*height))
        path.addLine(to: CGPoint(x: 0.7722*width, y: 0.2319*height))
        path.addCurve(to: CGPoint(x: 0.83152*width, y: 0.31122*height), control1: CGPoint(x: 0.76867*width, y: 0.26907*height), control2: CGPoint(x: 0.79406*width, y: 0.30302*height))
        path.addLine(to: CGPoint(x: 0.84086*width, y: 0.31326*height))
        path.addCurve(to: CGPoint(x: 0.87924*width, y: 0.42828*height), control1: CGPoint(x: 0.89445*width, y: 0.32499*height), control2: CGPoint(x: 0.91555*width, y: 0.38822*height))
        path.addLine(to: CGPoint(x: 0.87333*width, y: 0.4348*height))
        path.addCurve(to: CGPoint(x: 0.87333*width, y: 0.53302*height), control1: CGPoint(x: 0.84789*width, y: 0.46287*height), control2: CGPoint(x: 0.84789*width, y: 0.50495*height))
        path.addLine(to: CGPoint(x: 0.87924*width, y: 0.53954*height))
        path.addCurve(to: CGPoint(x: 0.84086*width, y: 0.65456*height), control1: CGPoint(x: 0.91555*width, y: 0.5796*height), control2: CGPoint(x: 0.89445*width, y: 0.64283*height))
        path.addLine(to: CGPoint(x: 0.83152*width, y: 0.6566*height))
        path.addCurve(to: CGPoint(x: 0.7722*width, y: 0.73592*height), control1: CGPoint(x: 0.79406*width, y: 0.6648*height), control2: CGPoint(x: 0.76867*width, y: 0.69875*height))
        path.addLine(to: CGPoint(x: 0.77306*width, y: 0.74498*height))
        path.addCurve(to: CGPoint(x: 0.6726*width, y: 0.81606*height), control1: CGPoint(x: 0.7781*width, y: 0.79801*height), control2: CGPoint(x: 0.72298*width, y: 0.83701*height))
        path.addLine(to: CGPoint(x: 0.66305*width, y: 0.81208*height))
        path.addCurve(to: CGPoint(x: 0.56734*width, y: 0.84229*height), control1: CGPoint(x: 0.62786*width, y: 0.79745*height), control2: CGPoint(x: 0.58697*width, y: 0.81036*height))
        path.addLine(to: CGPoint(x: 0.56208*width, y: 0.85085*height))
        path.addCurve(to: CGPoint(x: 0.43792*width, y: 0.85085*height), control1: CGPoint(x: 0.53402*width, y: 0.89651*height), control2: CGPoint(x: 0.46598*width, y: 0.89651*height))
        path.addLine(to: CGPoint(x: 0.43266*width, y: 0.84229*height))
        path.addCurve(to: CGPoint(x: 0.33695*width, y: 0.81208*height), control1: CGPoint(x: 0.41303*width, y: 0.81036*height), control2: CGPoint(x: 0.37214*width, y: 0.79745*height))
        path.addLine(to: CGPoint(x: 0.3274*width, y: 0.81606*height))
        path.addCurve(to: CGPoint(x: 0.22694*width, y: 0.74498*height), control1: CGPoint(x: 0.27702*width, y: 0.83701*height), control2: CGPoint(x: 0.2219*width, y: 0.79801*height))
        path.addLine(to: CGPoint(x: 0.2278*width, y: 0.73592*height))
        path.addCurve(to: CGPoint(x: 0.16847*width, y: 0.6566*height), control1: CGPoint(x: 0.23133*width, y: 0.69875*height), control2: CGPoint(x: 0.20594*width, y: 0.6648*height))
        path.addLine(to: CGPoint(x: 0.15914*width, y: 0.65456*height))
        path.addCurve(to: CGPoint(x: 0.12076*width, y: 0.53954*height), control1: CGPoint(x: 0.10555*width, y: 0.64283*height), control2: CGPoint(x: 0.08445*width, y: 0.5796*height))
        path.addLine(to: CGPoint(x: 0.12667*width, y: 0.53302*height))
        path.addCurve(to: CGPoint(x: 0.12667*width, y: 0.4348*height), control1: CGPoint(x: 0.15211*width, y: 0.50495*height), control2: CGPoint(x: 0.15211*width, y: 0.46287*height))
        path.addLine(to: CGPoint(x: 0.12076*width, y: 0.42828*height))
        path.addCurve(to: CGPoint(x: 0.15914*width, y: 0.31326*height), control1: CGPoint(x: 0.08445*width, y: 0.38822*height), control2: CGPoint(x: 0.10555*width, y: 0.32499*height))
        path.addLine(to: CGPoint(x: 0.16847*width, y: 0.31122*height))
        path.addCurve(to: CGPoint(x: 0.2278*width, y: 0.2319*height), control1: CGPoint(x: 0.20594*width, y: 0.30302*height), control2: CGPoint(x: 0.23133*width, y: 0.26907*height))
        path.addLine(to: CGPoint(x: 0.22694*width, y: 0.22284*height))
        path.addCurve(to: CGPoint(x: 0.3274*width, y: 0.15176*height), control1: CGPoint(x: 0.2219*width, y: 0.16981*height), control2: CGPoint(x: 0.27702*width, y: 0.13081*height))
        path.addLine(to: CGPoint(x: 0.33695*width, y: 0.15574*height))
        path.addCurve(to: CGPoint(x: 0.43266*width, y: 0.12553*height), control1: CGPoint(x: 0.37214*width, y: 0.17037*height), control2: CGPoint(x: 0.41303*width, y: 0.15746*height))
        path.addLine(to: CGPoint(x: 0.43792*width, y: 0.11697*height))
        path.closeSubpath()
        return path
    }
}

struct RoundedStar: Shape {
    var points: Int
    var cornerRadius: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(cornerRadius, CGFloat(points)) }
        set {
            cornerRadius = newValue.first
            points = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.6 - rc
        
        // Calculate the angle between each point in the star
        let angleIncrement = 360.0 / Double(points)
        // Start angle at -18 degrees to point up (for a 5-point star)
        var cangle = -18.0
        
        for i in 1...points {
            // Compute center point of tip arc
            let cc = CGPoint(
                x: center.x + rn * CGFloat(cos(Angle(degrees: cangle).radians)),
                y: center.y + rn * CGFloat(sin(Angle(degrees: cangle).radians))
            )
            
            // Compute tangent point along tip arc
            let p = CGPoint(
                x: cc.x + rc * CGFloat(cos(Angle(degrees: cangle - angleIncrement / 2).radians)),
                y: cc.y + rc * CGFloat(sin(Angle(degrees: cangle - angleIncrement / 2).radians))
            )
            
            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }
            
            // Add an arc to draw the rounded corner
            path.addArc(
                center: cc,
                radius: rc,
                startAngle: Angle(degrees: cangle - angleIncrement / 2),
                endAngle: Angle(degrees: cangle + angleIncrement / 2),
                clockwise: false
            )
            
            // Move to the next point in the star
            cangle += angleIncrement * 2 // Move to the next star tip
        }
        
        path.closeSubpath()
        return path
    }
}