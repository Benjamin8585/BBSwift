//
//  IfLet.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
#if !os(macOS)
import SwiftUI

public struct IfLet<T, Out: View>: View {
    let value: T?
    let produce: (T) -> Out

    init(_ value: T?, produce: @escaping (T) -> Out) {
        self.value = value
        self.produce = produce
    }

    var body: some View {
        Group {
            if value != nil {
                produce(value!)
            }
        }
    }
}
#endif
