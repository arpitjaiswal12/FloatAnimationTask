
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
                    .floatAnimation(thrershold: CGPoint(x: 100, y: 10))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            VStack {
                image
                    
                    .background()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 20)
                    .floatAnimation(thrershold: CGPoint(x: 20, y: 20))
                    
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
