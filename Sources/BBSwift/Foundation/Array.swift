//
//  Array.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

struct TwoDimension<T>: Identifiable {

    var id: UUID
    var elem1: T
    var elem2: T

    init(elem1: T, elem2: T) {
        self.id = UUID()
        self.elem1 = elem1
        self.elem2 = elem2
    }
}

extension Array {
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
