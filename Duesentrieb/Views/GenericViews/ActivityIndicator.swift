import SwiftUI

struct ActivityIndicator: View {
    @State private var isAnimating: Bool = false
    
    func circleOffsetY(for size: CGSize) -> CGFloat {
        let width = size.width / CGFloat(10.0)
        let height = size.height / CGFloat(2.0)
        return width - height
    }
    
    func scaleEffect(for index: Int) -> CGFloat {
        if isAnimating {
            return CGFloat(0.2) + CGFloat(index) / CGFloat(5)
        }
        return CGFloat(1) - CGFloat(index) / CGFloat(5)
    }
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(scaleEffect(for: index))
                        .offset(y: circleOffsetY(for: geometry.size))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear { self.isAnimating = true }
        .onDisappear { self.isAnimating = false }
    }
}
