//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 20/12/2020.
//

import Foundation
import SwiftUI

#if os(iOS)

public struct BBTextField: UIViewRepresentable {
    
    @Binding public var value: String
    
    public var placeholder: String
    public var color: Color?
    public var keyboardType: UIKeyboardType
    public var autoCorrection: Bool
    
    public init(placeholder: String, value: Binding<String>, color: Color? = nil, keyboardType: UIKeyboardType = .default, autoCorrection: Bool = false) {
        self.placeholder = placeholder
        self._value = value
        self.color = color
        self.keyboardType = keyboardType
        self.autoCorrection = autoCorrection
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = self.keyboardType
        textfield.tintColor = self.color?.uiColor()
        textfield.textColor = self.color?.uiColor()
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "done".localized(bundle: .module), style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([space, doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        textfield.delegate = context.coordinator
        textfield.text = self.value
        textfield.placeholder = placeholder
        textfield.autocorrectionType = self.autoCorrection ? .yes : .no
        return textfield
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        
    }
    
    public func makeCoordinator() -> BBTextField.Coordinator {
        Coordinator(tf: self)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        
        var tf: BBTextField

        init(tf: BBTextField) {
            self.tf = tf
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            tf.value = textField.text ?? ""
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = tf.value
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            textField.text = tf.value
        }

    }
}
#endif
