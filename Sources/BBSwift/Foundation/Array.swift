//
//  Array.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public func unique<S : Sequence, T : Equatable>(source: S) -> [T] where S.Iterator.Element == T {
    var added = Array<T>()
    for elem in source {
        if !added.contains(elem) {
            added.append(elem)
        }
    }
    return added
}

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

struct Zip3Generator<A: IteratorProtocol, B: IteratorProtocol, C: IteratorProtocol>: IteratorProtocol {

    private var first: A
    private var second: B
    private var third: C

    private var index = 0

    init(_ first: A, _ second: B, _ third: C) {
        self.first = first
        self.second = second
        self.third = third
    }

    // swiftlint:disable large_tuple
    mutating func next() -> (A.Element, B.Element, C.Element)? {
        if let first = first.next(), let second = second.next(), let third = third.next() {
            return (first, second, third)
        }
        return nil
    }
}

func zip<A: Sequence, B: Sequence, C: Sequence>(_ first: A, _ second: B, _ third: C) -> IteratorSequence<Zip3Generator<A.Iterator, B.Iterator, C.Iterator>> {
    return IteratorSequence(Zip3Generator(first.makeIterator(), second.makeIterator(), third.makeIterator()))
}

public struct ThreeDimension<T>: Identifiable {

    public var id: UUID
    public var elem1: T
    public var elem2: T
    public var elem3: T

    public init(elem1: T, elem2: T, elem3: T) {
        self.id = UUID()
        self.elem1 = elem1
        self.elem2 = elem2
        self.elem3 = elem3
    }
}

public extension Array {
    func threeDimentions() -> [ThreeDimension<Element>] {
        var one: [Element] = []
        var two: [Element] = []
        var three: [Element] = []
        self.enumerated().forEach { (i, p) in
            if i % 2 == 0 {
                one.append(p)
            } else if i % 2 == 1 {
                two.append(p)
            } else {
                three.append(p)
            }
        }
        return zip(one, two, three).map { (e1, e2, e3) -> ThreeDimension<Element> in
            return ThreeDimension<Element>(elem1: e1, elem2: e2, elem3: e3)
        }
    }
}
