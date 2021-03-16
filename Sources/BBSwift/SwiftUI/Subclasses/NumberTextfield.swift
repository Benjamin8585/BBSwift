//
//  NumberTextField.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/27.
//

import Foundation
import SwiftUI

#if os(iOS)
public enum NumberTextFieldType {
    case integer, price, weight, custom(format: String)
}

public struct NumberTextField: UIViewRepresentable {
    
    @Binding public var value : Double?
    
    @Environment(\.font) var font: Font?
    
    public var placeholder: String
    var accentColor: Color?
    var type: NumberTextFieldType
    var alignment: NSTextAlignment
    
    var proxy: Binding<String?> {
         Binding<String?>(
             get: {
                if let value = self.value {
                    switch self.type {
                    case .integer:
                        return String(format: "%.0f", Double(value))
                    case .price:
                        return String(format: "%.02f", Double(value))
                    case .weight:
                        return Double(value).weightFormatted()
                    case .custom(let format):
                        return String(format: format, Double(value))
                    }
                } else {
                    return nil
                }
             },
             set: {
                guard let doubleValue = $0?.emptyFiltered() else {
                    self.value = nil
                    return
                }
                let dotFormatter = NumberFormatter()
                dotFormatter.decimalSeparator = "."
                let commaFormatter = NumberFormatter()
                commaFormatter.decimalSeparator = ","
                if let value = dotFormatter.number(from: doubleValue) {
                    self.value = value.doubleValue
                } else if let value = commaFormatter.number(from: doubleValue) {
                    self.value = value.doubleValue
                }
             }
         )
     }
    
    public init(placeholder: String, value: Binding<Double?>, type: NumberTextFieldType, accentColor: Color? = nil, alignment: NSTextAlignment = .left) {
        self.placeholder = placeholder
        self._value = value
        self.type = type
        self.accentColor = accentColor
        self.alignment = alignment
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = .decimalPad
        textfield.tintColor = self.accentColor?.uiColor()
        textfield.textAlignment = self.alignment
        if let font = self.font, #available(iOS 14.0, *) {
            textfield.font = UIFont.with(font: font)
        }
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "done".localized(bundle: .module), style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([space, doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        textfield.delegate = context.coordinator
        textfield.text = self.proxy.wrappedValue
        textfield.placeholder = placeholder
        return textfield
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        if let font = self.font, #available(iOS 14.0, *) {
            uiView.font = UIFont.with(font: font)
        }
    }
    
    public func makeCoordinator() -> NumberTextField.Coordinator {
        Coordinator(tf: self)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        
        var tf: NumberTextField

        init(tf: NumberTextField) {
            self.tf = tf
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            tf.proxy.wrappedValue = textField.text
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = tf.proxy.wrappedValue
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            textField.text = tf.proxy.wrappedValue
        }

    }
}

#endif
