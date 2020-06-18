//
//  BackButton.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

#if !os(macOS)
import SwiftUI


struct BackButton: View {

    var title: String
    var action: () -> Void
    var color: Color

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "arrow.left.circle")
                Text(self.title)
            }.foregroundColor(color)
        }
    }

    /// Return a default back button
    static func `default`(title: String) -> BackButton {
        return BackButton(title: title, action: { BBSwift.router.pop(animated: true )}, color: Colors.black)
    }
}
#endif
