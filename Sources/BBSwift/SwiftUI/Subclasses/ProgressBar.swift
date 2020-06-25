//
//  ProgressBar.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

#if !os(macOS)
import SwiftUI

public struct ProgressBar: View {

    @Binding var value: Float
    
    var backgroundColor: Color
    var indicatorColor: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(indicatorColor)

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(backgroundColor)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

/// A progressbar running indifinitely
public struct InfiniteProgressBar: View {

    @State private var isAnimating: Bool = false

    var indicatorWidth: CGFloat = 30.0
    var backgroundColor: Color
    var indicatorColor: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(self.backgroundColor)
                Rectangle().frame(width: self.indicatorWidth, height: geometry.size.height)
                    .offset(x: self.isAnimating ? geometry.size.width : -self.indicatorWidth, y: 0)
                    .foregroundColor(self.indicatorColor)
                    .animation(Animation.linear(duration: 1.2).repeatForever())
                    .onAppear {
                        self.isAnimating = true
                    }
            }.cornerRadius(45.0)
        }
    }

    mutating func indicatorColor(color: Color) {
        self.indicatorColor = color
    }
}

struct ProgressBar_Previews: PreviewProvider {
    
    @State var progressValue: Float = 0.30
    
    static var previews: some View {
        VStack {
            ProgressBar(value: $progressValue, backgroundColor: Color.white, indicatorColor: Colors.green).frame(height: 20)
            InfiniteProgressBar(backgroundColor: Color.white, indicatorColor: Colors.green).frame(height: 20)
            Spacer()
        }.padding()
    }
}
#endif
