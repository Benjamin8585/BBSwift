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
    @Binding var objects: [Any]
    
    public init(objects: Binding<[Any]>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._objects = objects
    }
    
    public var body: some View {
        VStack {
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
        CustomList(objects: $objects) {
            Text("Ceci est un test")
        }
    }
}

struct CustomList_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomListWrapper()
    }
}