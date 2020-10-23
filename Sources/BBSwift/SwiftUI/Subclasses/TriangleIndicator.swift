//
//  TriangleIndicator.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI

public enum TriangleDirection {
    case down, up, right, left
}

public struct TriangleIndicator: View {

    var width: CGFloat
    var height: CGFloat
    var color: Color
    var direction: TriangleDirection

    public init(color: Color = Color.black, width: CGFloat = 12.0, height: CGFloat = 8.0, direction: TriangleDirection = .down) {
        self.color = color
        self.direction = direction
        self.width = width
        self.height = height
    }

    public var degrees: Double {
        switch self.direction {
        case .down:
            return 0
        case .left:
            return 90
        case .up:
            return 180
        case .right:
            return 270
        }
    }

    public var body: some View {
        Group {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: self.width / 2, y: self.height))
                path.addLine(to: CGPoint(x: self.width, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
            }.fill(self.color).rotationEffect(.degrees(self.degrees))
        }.frame(width: self.width, height: self.height)
    }
}

struct TriangleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TriangleIndicator(color: Color.red, direction: .up)
            TriangleIndicator(color: Color.black, direction: .down)
            TriangleIndicator(color: Color.blue, direction: .left)
            TriangleIndicator(color: Color.yellow, direction: .right)
        }
    }
}
