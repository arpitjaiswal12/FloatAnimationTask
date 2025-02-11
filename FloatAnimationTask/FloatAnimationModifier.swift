//
//  FloatAnimationModifier.swift
//  FloatAnimationTask
//
//  Created by Arpit Jaiswal on 10/02/25.
//

import CoreMotion
import SwiftUI

class MotionManager : ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    init() {
        if motionManager.isAccelerometerAvailable {
//            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main){ data, error in
                guard let motion = data?.attitude else { return }
                DispatchQueue.main.async {
                    self.x = motion.roll
                    self.y = motion.pitch
                }
            }
        }
    }
}

struct FloatAnimation : ViewModifier {
    @StateObject private var motion = MotionManager()
    var xThreshold : CGFloat
    var yThreshold : CGFloat
    init(xThreshold: CGFloat = 50, yThreshold: CGFloat = 50) {
        self.xThreshold = xThreshold
        self.yThreshold = yThreshold
    }
    func body(content: Content) -> some View {
        content
//            .background()
//            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
//            .shadow(radius: 20)
            .offset(
                x: motion.x < 0 ? max(motion.x, -1.30) * xThreshold : motion.x > 0 ? min(motion.x, 1.30) * xThreshold : 0,
                y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * yThreshold * 1.5))
            .animation(.spring(duration: 0.5), value: motion.x)
            .animation(.spring(duration: 0.5), value: motion.y)
    }
}

extension View {
    func floatAnimation(x : CGFloat, y: CGFloat) -> some View {
        modifier(FloatAnimation(xThreshold: x, yThreshold: y))
    }
}
