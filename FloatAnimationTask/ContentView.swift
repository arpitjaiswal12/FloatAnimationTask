//
//  ContentView.swift
//  FloatAnimationTask
//
//  Created by Arpit Jaiswal on 07/02/25.
//
import CoreMotion
import SwiftUI

class MotionManager : ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
           
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
//            print("x value \(String(describing: self?.x)) and y value \(String(describing: self?.y))")
            print("x max value \(Double(round(max(self?.x ?? 0, -1.30) * 1000)/1000)) and y max value \(Double(round(max(self?.y ?? 0, -1.30) * 1000)/1000))")
            print("x min value \(Double(round(max(self?.x ?? 0, 1.30) * 1000)/1000)) and y min value \(Double(round(max(self?.y ?? 0, 1.30) * 1000)/1000))")
            
        }
    }
}


struct ContentView: View {
    @StateObject private var motion = MotionManager()
    var thresholdValue : Double = 20
    var image : Image  = Image(.qrCode)
    var myColor : Color = Color(red: 95/255.0, green: 88/255.0, blue: 81/255.0)
    var body: some View {
        /*ZStack {
         //            Color(red: 82 / 255.0, green: 75 / 255.0, blue: 81 / 255.0)
         Color.black
         VStack {
         Circle()
         .fill(
         Color.white.opacity(0.0)
         )
         .backgroundStyle(
         .white.shadow(
         .drop(color: Color.white, radius: 50, x: motion.x * 20, y: motion.y * 20)
         )
         )
         }
         .padding(EdgeInsets(top: 0, leading: -200, bottom: 300, trailing: 0))
         
         
         VStack {
         Image(.qrCode)
         .background()
         .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 50)
         .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
         }
         .backgroundStyle(
         .white.shadow(
         .drop(color: Color.white, radius: 50, x: motion.x * 20, y: motion.y * 20)
         )
         )
         .rotation3DEffect(
         .degrees(motion.x * 20),
         axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
         )
         
         
         
         }
         .ignoresSafeArea() */
        
        /* ZStack {
            Color.black
            VStack  {
                Circle()
                    .fill(
                        RadialGradient(colors: [.white, .brown, .black], center: .center, startRadius: 0,  endRadius: 300)
                    )
                    .opacity(0.5)
                    .padding(EdgeInsets(top: 0, leading: 200, bottom: 300, trailing: 0))
            }
            
            VStack {
                Image(.qrCode)
                    .background()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            }
            .backgroundStyle(
                .white.shadow(
                    .drop(color: Color.white, radius: 50, x: motion.x * 20, y: motion.y * 20)
                )
            )
            .rotation3DEffect(
                .degrees(motion.x * 20),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .rotation3DEffect(
                .degrees(motion.y * 20),
                axis: (x: 1.0, y: 0.0, z: 0.0)
            )
            
        }
        .ignoresSafeArea() */
        
        ZStack {
            myColor
//            VStack {
//                VStack {
            VStack {
                RadialGradient(colors: [.white, myColor, myColor], center: .center, startRadius: 0, endRadius: 500)
            .blur(radius: 90)
            
            .offset(x: motion.x * 100 , y: motion.y * thresholdValue)
            }
            .offset(x: -150 , y: -200)
            .offset(x: motion.x * 50 , y: motion.y * 100)
            VStack {
                image
                    .background()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .padding(
                        EdgeInsets(
                            top: motion.y < 0 ? max(motion.y, -1.30) * thresholdValue : motion.y > 0 ? min(motion.y, 1.30) * thresholdValue : 0 ,
                            leading: motion.x < 0 ? max(motion.x, -1.30) * thresholdValue : motion.x > 0 ? min(motion.x, 1.30) * thresholdValue : 0 ,
                            bottom: 0,
                            trailing: 0
                        )
                    )
            }
        }
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
