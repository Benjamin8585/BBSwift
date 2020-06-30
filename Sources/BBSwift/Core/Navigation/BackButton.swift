//
//  BackButton.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI


public struct BackButton: View {

    public var title: String
    public var action: () -> Void
    public var color: Color
    
    public init(title: String, action: @escaping () -> Void, color: Color) {
        self.title = title
        self.action = action
        self.color = color
    }

    public var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "arrow.left.circle")
                Text(self.title)
            }.foregroundColor(color)
        }
    }
}
