
import CoreMotion
import SwiftUI

struct ContentView: View {
    var thresholdValue : Double {
        return 20
    }
    var image : Image  = Image(.qrCode)
    var myColor : Color = Color(red: 95/255.0, green: 88/255.0, blue: 81/255.0)
    var body: some View {
        ZStack {
            myColor
            VStack {
                RadialGradient(colors: [.white, myColor, myColor], center: .center, startRadius: 0, endRadius: 500)
                    .blur(radius: 95)
                    .padding(.top, 29)
                    .padding(.trailing, 77)
                    .frame(width: 400,height: 400)
//                    .border(Color.red)
//                    .offset(x: motion.x < 0 ? max(motion.x, -1.30) * 100 : motion.x > 0 ? min(motion.x, 1.30) * 100 : 0 , y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * thresholdValue))
//                    .offset(x: motion.x * 100 , y: motion.y * thresholdValue)
                    .floatAnimation(thrershold: CGPoint(x: 100, y: 10))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//            .border(Color.yellow)
//            .offset(x: -150, y: -200)
//            .offset(x: motion.x < 0 ? max(motion.x, -1.30) * 50 : motion.x > 0 ? min(motion.x, 1.30) * 50 : 0 , y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * 100))
//            .floatAnimation(x: 50, y: 100)
            VStack {
                image
                    
                    .background()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 20)
//                    .offset(
//                        x:motion.x < 0 ? max(motion.x, -1.30) * thresholdValue : motion.x > 0 ? min(motion.x, 1.30) * thresholdValue : 0,
//                        y: ((motion.y < 0 ? max(motion.y, -1.30) : motion.y > 0 ? min(motion.y, 1.30) : 0) * thresholdValue * 1.5))
                    .floatAnimation(thrershold: CGPoint(x: 20, y: 20))
                    
            }
        }
//        .animation(.spring(duration: 0.5), value: motion.x)
//        .animation(.spring(duration: 0.5), value: motion.y)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
