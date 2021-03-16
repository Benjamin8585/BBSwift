//
//  BBTextfield.swift
//  BBSwift
//  
//
//  Created by Benjamin Bourasseau on 20/12/2020.
//

import Foundation
import SwiftUI

#if os(iOS)

public struct BBTextField: UIViewRepresentable {
    
    @Binding public var value: String
    
    @Environment(\.font) var font: Font?
    
    public var placeholder: String
    public var color: Color?
    public var keyboardType: UIKeyboardType
    public var autoCorrection: Bool
    public var autoCapitalizationType: UITextAutocapitalizationType
    public var placeholderColor: UIColor
    public var isSecure: Bool
    
    public init(placeholder: String, value: Binding<String>, color: Color? = nil, keyboardType: UIKeyboardType = .default, autoCorrection: Bool = false, autoCapitalizationType: UITextAutocapitalizationType = .sentences, placeholderColor: UIColor = UIColor.gray, isSecure: Bool = false) {
        self.placeholder = placeholder
        self._value = value
        self.color = color
        self.keyboardType = keyboardType
        self.autoCorrection = autoCorrection
        self.autoCapitalizationType = autoCapitalizationType
        self.placeholderColor = placeholderColor
        self.isSecure = isSecure
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.isSecureTextEntry = self.isSecure
        textfield.keyboardType = self.keyboardType
        textfield.tintColor = self.color?.uiColor()
        textfield.textColor = self.color?.uiColor()
        textfield.autocapitalizationType = self.autoCapitalizationType
        if let font = self.font, #available(iOS 14.0, *) {
            textfield.font = UIFont.with(font: font)
        }
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "done".localized(), style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([space, doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        textfield.delegate = context.coordinator
        textfield.text = nil
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: self.placeholderColor])
        textfield.autocorrectionType = self.autoCorrection ? .yes : .no
        return textfield
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.value
        if let font = self.font, #available(iOS 14.0, *) {
            uiView.font = UIFont.with(font: font)
        }
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

public extension UITextField {
    @objc func doneButtonTapped(button: UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }

}
#endif
