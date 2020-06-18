//
//  CGPoint.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import CoreGraphics

public extension CGPoint {

    /// Return middle of two points
    static func midPoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }

    /// Return the control point of two points
    static func controlPoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        var controlPoint = midPoint(p1: p1, p2: p2)
        let diffY = abs(p2.y - controlPoint.y)
        if p1.y < p2.y {
            controlPoint.y += diffY
        } else if p1.y > p2.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }

}
