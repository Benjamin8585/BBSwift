//
//  ScrollableView.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI
import Introspect

@available(iOS 13.0, *)
public struct ScrollableView<Content>: View where Content: View {
    
    private let content: Content
    
    @Binding var shouldScrollToBottom: Bool
    @Binding var scrollAnimated: Bool
    
    @State var contentOffset: CGPoint = .zero

    public init(shouldScroll: Binding<Bool>, animated: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._scrollAnimated = animated
        self._shouldScrollToBottom = shouldScroll
    }
    
    func scrollToBottom(animated: Bool) {
        self.scrollAnimated = animated
    }

    public var body : some View {
        ScrollView {
            content
        }.introspectScrollView { (sv) in
            if self.shouldScrollToBottom {
                let bottom: CGPoint = CGPoint(x: 0, y: sv.contentSize.height - sv.bounds.size.height + sv.contentInset.bottom)
                sv.setContentOffset(bottom, animated: self.scrollAnimated)
            }
        }
    }
}

struct ScrollableViewContainer: View {
    
    @State var shouldScroll: Bool = false
    @State var animated: Bool = false
    
    var body: some View {
        ScrollableView(shouldScroll: $shouldScroll, animated: $animated) {
            Text("Ok")
            Text("Cool")
        }
    }
    
}

struct ScrollableView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollableViewContainer()
        }
    }
}
