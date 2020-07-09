//
//  Array.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public struct TwoDimension<T>: Identifiable {

    public var id: UUID
    public var elem1: T
    public var elem2: T

    public init(elem1: T, elem2: T) {
        self.id = UUID()
        self.elem1 = elem1
        self.elem2 = elem2
    }
}

public extension Array {
    func twoDimentions() -> [TwoDimension<Element>] {
        var odds: [Element] = []
        var even: [Element] = []
        self.enumerated().forEach { (i, p) in
            if i % 2 == 0 {
                odds.append(p)
            } else {
                even.append(p)
            }
        }
        return zip(odds, even).map { (e1, e2) -> TwoDimension<Element> in
            return TwoDimension<Element>(elem1: e1, elem2: e2)
        }
    }
}
