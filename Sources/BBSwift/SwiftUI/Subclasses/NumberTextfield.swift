//
//  NumberTextField.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/27.
//

import Foundation
import SwiftUI
import Combine

struct NumberTextField : View {
    
    @State private var enteredValue : String = ""
    @Binding var value : Double
    var placeholder: String
    
    init(placeholder: String, value: Binding<Double>) {
        self.placeholder = placeholder
        self._value = value
        self.enteredValue = "\(self.value)"
    }

    var body: some View {
        return TextField(self.placeholder, text: $enteredValue)
            .keyboardType(.numberPad)
            .onReceive(Just(enteredValue)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue, let new = Double(filtered) {
                    self.value = new
                }
        }
    }
}
