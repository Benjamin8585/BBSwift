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
    let placeholderColor: Color?
    let textColor: Color?
    let minHeight: CGFloat
    let maxHeight: CGFloat
    let accentColor: Color?
    
    /// Create a Growing text view. If no placeholder is provided the color is set to textColor. minHeight and maxheight are the min and max size of the textview
    public init(text: Binding<String>, placeholder: String, textColor: Color? = nil, placeholderColor: Color? = nil,  minHeight: CGFloat = 39.0, maxHeight: CGFloat = 150.0, accentColor: Color?) {
        self._text = text
        self.placeholder = placeholder
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.accentColor = accentColor
    }

    public var countedHeight: CGFloat {
        min(max(minHeight, contentHeight), maxHeight)
    }

    public var body: some View {
        TextViewWrapper(placeholder: self.placeholder, placeholderColor: placeholderColor ?? BBColor.Text.main.getColor(scheme: scheme), textColor: textColor ?? BBColor.Text.main.getColor(scheme: scheme), accentColor: accentColor ?? BBColor.Text.main.getColor(scheme: scheme), text: $text, focused: $focused, contentHeight: $contentHeight).frame(height: countedHeight)
    }
}

public struct TextViewWrapper: UIViewRepresentable {
    
    let placeholder: String
    let placeholderColor: UIColor
    let textColor: UIColor
    let accentColor: UIColor
    
    @Binding var text: String
    @Binding var focused: Bool
    @Binding var contentHeight: CGFloat

    public init(placeholder: String, placeholderColor: Color, textColor: Color, accentColor: Color, text: Binding<String>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>) {
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor.uiColor()
        self.textColor = textColor.uiColor()
        self.accentColor = accentColor.uiColor()
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

        public init(text: Binding<String>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>) {
          self._text = text
          self._focused = focused
          self._contentHeight = contentHeight
        }

        // MARK: - UITextViewDelegate
        public func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.contentHeight = textView.contentSize.height
        }

        public func textViewDidBeginEditing(_ textView: UITextView) {
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
            GrowingTextView(text: .constant(""), placeholder: "Here is the placeholder", accentColor: Color.blue).background(Color.red)
            Spacer()
        }
    }
}
#endif
