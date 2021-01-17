//
//  CustomList.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import SwiftUI

/// This list is made to be scrollable and avoid the problem of not showing up when content is empty
public struct CustomList<Content>: View where Content: View {
    
    private let content: Content
    var objects: [Any]
    var spacing: CGFloat?
    
    public init(_ objects: [Any], spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.objects = objects
        self.spacing = spacing
    }
    
    public var body: some View {
        VStack(spacing: self.spacing) {
            GeometryReader { proxy in
                ZStack {
                    if self.objects.count > 0 {
                        ScrollView {
                            self.content
                        }
                    } else {
                        EmptyView()
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}

struct CustomListWrapper: View {
    
    @State var objects: [Any] = ["Ok", "Ok"]
    
    var body: some View {
        CustomList(objects) {
            Text("Ceci est un test")
        }
    }
}

struct CustomList_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomListWrapper()
    }
}
