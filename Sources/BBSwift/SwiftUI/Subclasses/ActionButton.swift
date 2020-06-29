//
//  ActionButton.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

/// Easy loading button
public struct ActionButton: View {

    @Binding var isLoading: Bool
    var buttonInfo: (color: Color, text: String, image: String?)
    var height: CGFloat
    var bottom: CGFloat
    var top: CGFloat
    
    init(isLoading: Binding<Bool>, buttonInfo: (color: Color, text: String, image: String?), height: CGFloat = 80.0, bottom: CGFloat = 0.0, top: CGFloat = 0.0) {
        self._isLoading = isLoading
        self.buttonInfo = buttonInfo
        self.height = height
        self.bottom = bottom
        self.top = top
    }

    public var body: some View {
        ZStack {
            self.buttonInfo.color
            HStack {
                Spacer()
                if self.isLoading {
                    ButtonActivityIndicator().frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                } else {
                    HStack {
                        if self.buttonInfo.image != nil {
                            Image(systemName: self.buttonInfo.image!)
                        }
                        Text(self.buttonInfo.text)
                    }.frame(height: 25.0)
                }
                Spacer()
            }
            .padding(.bottom, self.bottom)
            .padding(.top, self.top)
            .foregroundColor(Color.white)
        }.frame(height: height)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActionButton(isLoading: .constant(true), buttonInfo: (Color.blue, "Add Text", "bolt.fill"))
            ActionButton(isLoading: .constant(false), buttonInfo: (Color.blue, "Add Text", "bolt.fill"))
        }
    }
}
