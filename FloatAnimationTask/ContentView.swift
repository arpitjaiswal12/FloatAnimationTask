
import CoreMotion
import SwiftUI

class MotionManager : ObservableObject {
    private let motionManager = CMMotionManager()
    
    @Published var x = 0.0
    @Published var y = 0.0
    init() {
//        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
//            guard let motion = data?.attitude else { return }
//            
//            //            print("Y ROTATION: ", data?.rotationRate.y.description.prefix(5) ?? "")
//            //            print("Z ROTATION: ", data?.rotationRate.z.description.prefix(5) ?? "")
//            //            print("Heading Angle", data?.heading ?? "")
//            print("roll: ", motion.roll.description.prefix(5))
//            print("pitch: ", motion.pitch.description.prefix(5))
//            print("yaw: ", motion.yaw.description.prefix(5))
//            self?.x = motion.roll
//            self?.y = motion.pitch
//            /*print("x max value \(Double(round(max(self?.x ?? 0, -1.30) * 1000)/1000)) and y max value \(Double(round(max(self?.y ?? 0, -1.30) * 1000)/1000))")
//             print("x min value \(Double(round(max(self?.x ?? 0, 1.30) * 1000)/1000)) and y min value \(Double(round(max(self?.y ?? 0, 1.30) * 1000)/1000))")*/
//        }
        
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


struct ContentView: View {
    @StateObject private var motion = MotionManager()
    var thresholdValue : Double = 20
    var image : Image  = Image(.qrCode)
    var myColor : Color = Color(red: 95/255.0, green: 88/255.0, blue: 81/255.0)
    var body: some View {
        ZStack {
            myColor
            VStack {
                RadialGradient(colors: [.white, myColor, myColor], center: .center, startRadius: 0, endRadius: 500)
                    .blur(radius: 90)
                    .offset(x: motion.x < 0 ? max(motion.x, -1.30) * 100 : motion.x > 0 ? min(motion.x, 1.30) * 100 : 0 , y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * thresholdValue))
//                    .offset(x: motion.x * 100 , y: motion.y * thresholdValue)
                    
            }
            .offset(x: -150, y: -200)
            .offset(x: motion.x < 0 ? max(motion.x, -1.30) * 50 : motion.x > 0 ? min(motion.x, 1.30) * 50 : 0 , y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * 100))
            
            VStack {
                image
                    .background()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 20)
                    .offset(
                        x:motion.x < 0 ? max(motion.x, -1.30) * thresholdValue : motion.x > 0 ? min(motion.x, 1.30) * thresholdValue : 0,
                        y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * thresholdValue * 1.5) )
//                    .padding(
//                        EdgeInsets(
//                            top: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * thresholdValue),
//                            leading: motion.x < 0 ? max(motion.x, -1.30) * thresholdValue : motion.x > 0 ? min(motion.x, 1.30) * thresholdValue : 0 ,
//                            bottom: 0,
//                            trailing: 0
//                        )
//                    )
            }
        }
        .animation(.spring(duration: 0.5), value: motion.x)
        .animation(.spring(duration: 0.5), value: motion.y)
        .ignoresSafeArea()
        .onAppear(perform: {
            print(motion.x)
            print(motion.y)
        })
    }
}


#Preview {
    ContentView()
}
