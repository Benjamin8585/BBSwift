//
//  GrowingTextView.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI

#if os(iOS)
public struct GrowingTextView: View {
    
    @Environment(\.colorScheme) var scheme: ColorScheme

    @Binding var text: String
    @State var focused: Bool = false
    @State var contentHeight: CGFloat = 0

    let placeholder: String
    let placeholderColor: UIColor?
    let textColor: UIColor?
    let minHeight: CGFloat
    let maxHeight: CGFloat
    let accentColor: UIColor?
    /// Decides whether or not you want a toolbar with the done button
    let withToolbar: Bool
    
    /// Create a Growing text view. If no placeholder is provided the color is set to textColor. minHeight and maxheight are the min and max size of the textview
    public init(text: Binding<String>, placeholder: String, textColor: UIColor? = nil, placeholderColor: UIColor? = nil,  minHeight: CGFloat = 39.0, maxHeight: CGFloat = 150.0, accentColor: UIColor?, withToolbar: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.accentColor = accentColor
        self.withToolbar = withToolbar
    }

    public var countedHeight: CGFloat {
        min(max(minHeight, contentHeight), maxHeight)
    }

    public var body: some View {
        TextViewWrapper(placeholder: self.placeholder, placeholderColor: placeholderColor ?? BBColor.Text.mainUI.getColor(scheme: scheme), textColor: textColor ?? BBColor.Text.mainUI.getColor(scheme: scheme), accentColor: accentColor ?? BBColor.Text.mainUI.getColor(scheme: scheme), text: $text, focused: $focused, contentHeight: $contentHeight, showToolbar: withToolbar).frame(height: countedHeight)
    }
}

public struct TextViewWrapper: UIViewRepresentable {
    
    let placeholder: String
    let placeholderColor: UIColor
    let textColor: UIColor
    let accentColor: UIColor
    let showToolbar: Bool
    
    @Binding var text: String
    @Binding var focused: Bool
    @Binding var contentHeight: CGFloat

    public init(placeholder: String, placeholderColor: UIColor, textColor: UIColor, accentColor: UIColor, text: Binding<String>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>, showToolbar: Bool) {
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.textColor = textColor
        self.accentColor = accentColor
        self.showToolbar = showToolbar
        self._text = text
        self._focused = focused
        self._contentHeight = contentHeight
    }

    // MARK: - UIViewRepresentable
    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.autocorrectionType = .no
        textView.tintColor = self.accentColor
        if self.showToolbar {
            let doneButton = UIBarButtonItem(title: "done".localized(bundle: .module), style: .done, target: context.coordinator, action: #selector(Coordinator.doneTapped))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44.0))
            toolbar.setItems([space, doneButton], animated: false)
            textView.inputAccessoryView = toolbar
        }
        return textView
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, focused: $focused, contentHeight: $contentHeight)
    }
    
    public var placeholderVisible: Bool {
        return self.text.emptyFiltered() == nil && !self.focused
    }
    
    public func getText() -> String {
        if placeholderVisible {
            return self.placeholder
        } else {
            return self.text
        }
    }
    
    public func getColor() -> UIColor {
        if placeholderVisible {
            return self.placeholderColor
        } else {
            return self.textColor
        }
    }

    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = getText()
        uiView.textColor = getColor()
    }

    public class Coordinator: NSObject, UITextViewDelegate {

        @Binding private var text: String
        @Binding private var focused: Bool
        @Binding private var contentHeight: CGFloat
        
        var textview: UITextView?

        public init(text: Binding<String>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>) {
          self._text = text
          self._focused = focused
          self._contentHeight = contentHeight
        }
        
        @objc func doneTapped() {
            self.textview?.resignFirstResponder()
        }

        // MARK: - UITextViewDelegate
        public func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.contentHeight = textView.contentSize.height
        }

        public func textViewDidBeginEditing(_ textView: UITextView) {
            self.textview = textView
            self.focused = true
        }

        public func textViewDidEndEditing(_ textView: UITextView) {
            self.focused = false
            self.contentHeight = text.emptyFiltered() == nil ? 0 : textView.contentSize.height
        }
    }
}

struct GrowingTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            GrowingTextView(text: .constant(""), placeholder: "Here is the placeholder", accentColor: UIColor.blue, withToolbar: true).background(Color.red)
            Spacer()
        }
    }
}
#endif
