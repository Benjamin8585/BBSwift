//
//  NumberTextField.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/27.
//

import Foundation
import SwiftUI
import Combine

public struct NumberTextField : View {
    
    @State private var enteredValue : String = ""
    @Binding public var value : Double?
    public var placeholder: String
    var accentColor: Color?
    
    public init(placeholder: String, value: Binding<Double?>, accentColor: Color = nil) {
        self.placeholder = placeholder
        self._value = value
        if let value = value.wrappedValue {
            self.enteredValue = "\(value)"
        } else {
            self.enteredValue = ""
        }
        self.accentColor = accentColor
    }

    public var body: some View {
        return TextField(self.placeholder, text: $enteredValue)
            .keyboardType(.numberPad)
            .onReceive(Just(enteredValue)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue, let new = Double(filtered) {
                    self.value = new
                }
        }.accentColor(self.accentColor)
    }
}
