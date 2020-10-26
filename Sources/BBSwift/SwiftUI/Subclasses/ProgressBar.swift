//
//  ProgressBar.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI

public struct ProgressBar: View {

    @Binding var value: Float
    
    var backgroundColor: Color
    var indicatorColor: Color
    
    public init(value: Binding<Float>, backgroundColor: Color, indicatorColor: Color) {
        self._value = value
        self.backgroundColor = backgroundColor
        self.indicatorColor = indicatorColor
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(self.indicatorColor)

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(self.backgroundColor)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}


/// A progressbar running indifinitely
@available(iOS 14.0, *)
private struct Infinite14ProgressBar: View {

    var indicatorWidth: CGFloat
    var backgroundColor: Color
    var indicatorColor: Color
    
    // iOS 14
    @Namespace private var animation
    @State private var shouldRevert: Bool = false
    
    public init(indicatorWidth: CGFloat = 30.0, backgroundColor: Color, indicatorColor: Color) {
        self.indicatorWidth = indicatorWidth
        self.backgroundColor = backgroundColor
        self.indicatorColor = indicatorColor
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(self.backgroundColor)
                if self.shouldRevert {
                    Rectangle().frame(width: self.indicatorWidth, height: geometry.size.height)
                        .offset(x: -self.indicatorWidth, y: 0)
                        .matchedGeometryEffect(id: "progress", in: animation)
                        .foregroundColor(self.indicatorColor)
                        .onAppear {
                            self.shouldRevert = false
                        }
                        .animation(Animation.linear(duration: 1.2))
                } else {
                    Rectangle().frame(width: self.indicatorWidth, height: geometry.size.height)
                        .offset(x: geometry.size.width, y: 0)
                        .matchedGeometryEffect(id: "progress", in: animation)
                        .foregroundColor(self.indicatorColor)
                        .onAppear {
                            self.shouldRevert = true
                        }
                        .animation(Animation.linear(duration: 1.2))
                        
                }
            }.cornerRadius(45.0)
        }
    }

    mutating func indicatorColor(color: Color) {
        self.indicatorColor = color
    }
}

/// A progressbar running indifinitely
private struct Infinite13ProgressBar: View {

    // iOS 13
    @State private var isAnimating: Bool = false

    var indicatorWidth: CGFloat
    var backgroundColor: Color
    var indicatorColor: Color
    
    public init(indicatorWidth: CGFloat = 30.0, backgroundColor: Color, indicatorColor: Color) {
        self.indicatorWidth = indicatorWidth
        self.backgroundColor = backgroundColor
        self.indicatorColor = indicatorColor
    }

    public var body: some View {
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

/// A progressbar running indifinitely
public struct InfiniteProgressBar: View {

    var indicatorWidth: CGFloat
    var backgroundColor: Color
    var indicatorColor: Color
    
    public init(indicatorWidth: CGFloat = 30.0, backgroundColor: Color, indicatorColor: Color) {
        self.indicatorWidth = indicatorWidth
        self.backgroundColor = backgroundColor
        self.indicatorColor = indicatorColor
    }

    public var body: some View {
        if #available(iOS 14.0, *) {
            Infinite14ProgressBar(indicatorWidth: indicatorWidth, backgroundColor: backgroundColor, indicatorColor: indicatorColor)
        } else {
            Infinite13ProgressBar(indicatorWidth: indicatorWidth, backgroundColor: backgroundColor, indicatorColor: indicatorColor)
        }
    }

    mutating func indicatorColor(color: Color) {
        self.indicatorColor = color
    }
}

struct ProgressBarWrapper: View {
    
    @State var progressValue: Float = 0.30
    
    var body: some View {
        ProgressBar(value: $progressValue, backgroundColor: Color.white, indicatorColor: BBColor.green).frame(height: 20)
    }
    
}

struct ProgressBar_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ProgressBarWrapper()
            InfiniteProgressBar(backgroundColor: Color.white, indicatorColor: BBColor.green).frame(height: 20)
            Spacer()
        }.padding()
    }
}
