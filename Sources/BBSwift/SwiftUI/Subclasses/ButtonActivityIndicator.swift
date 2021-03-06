//
//  ButtonActivityIndicator.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation

#if os(iOS)
import SwiftUI

public struct ButtonActivityIndicator: View {

    @State private var isAnimating: Bool = false
    
    public init() {
        
    }

    public var body: some View {
      GeometryReader { (geometry: GeometryProxy) in
        ZStack(alignment: .center) {
            ForEach(0..<5) { index in
              Group {
                Circle()
                  .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                  .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                  .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                  .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                  .animation(
                    Animation.timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5).repeatForever(autoreverses: false)
                  )
            }
        }.frame(width: geometry.size.width, height: geometry.size.height)
        }.onAppear {
            self.isAnimating = true
        }
    }
}

struct ButtonActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActivityIndicator().frame(width: 25, height: 25)
    }
}
#endif
