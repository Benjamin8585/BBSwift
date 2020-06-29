//
//  CATransition.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import UIKit

public extension CATransition {

    /// New viewController will appear from bottom of screen.
    public func segueFromBottom(duration: Double = 0.375) -> CATransition {
        let transition = CATransition()
        transition.duration = duration //set the duration to whatever you'd like.
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        return transition
    }

    /// New viewController will appear from top of screen.
    public static func segueFromTop(duration: Double = 0.375) -> CATransition {
        let transition = CATransition()
        transition.duration = duration //set the duration to whatever you'd like.
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromBottom
        return transition
    }
     /// New viewController will appear from left side of screen.
    public static func segueFromLeft(duration: Double = 0.375) -> CATransition {
        let transition = CATransition()
        transition.duration = duration //set the duration to whatever you'd like.
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        return transition
    }
    
    /// New viewController will pop from right side of screen.
    public static func popFromRight(duration: Double = 0.375) -> CATransition {
        let transition = CATransition()
        transition.duration = duration //set the duration to whatever you'd like.
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        return transition
    }

    /// New viewController will appear from left side of screen.
    public static func popFromLeft(duration: Double = 0.375) -> CATransition {
        let transition = CATransition()
        transition.duration = duration //set the duration to whatever you'd like.
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        return transition
    }
}
