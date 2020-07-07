//
//  PlaceholderOverlay.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public struct PlaceholderOverlay: View {
    
    @Environment(\.colorScheme) var scheme: ColorScheme

    var image: String
    var text: String
    var isLoading: Bool
    var showPlaceholderCondition: Bool
    var backgroundColor: Color?
    
    public init(image: String, text: String, isLoading: Bool, showPlaceholderCondition: Bool, backgroundColor: Color? = nil) {
        self.image = image
        self.text = text
        self.isLoading = isLoading
        self.showPlaceholderCondition = showPlaceholderCondition
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ZStack {
            Group {
                if !isLoading && !showPlaceholderCondition {
                    EmptyView()
                } else {
                    (self.backgroundColor ?? BBColor.Background.blackOrWhite.getColor(scheme: scheme)).opacity(!isLoading && !showPlaceholderCondition ? 0 : 1)
                    ZStack {
                        PlaceholderView(image: self.image, text: self.text)
                            .opacity(!isLoading && showPlaceholderCondition ? 1 : 0)
                        ButtonActivityIndicator()
                            .frame(width: 40, height: 40)
                            .offset(x: 0, y: -50)
                            .foregroundColor(BBColor.Text.grayMedium)
                            .opacity(isLoading ? 1 : 0)
                    }
                }
            }

        }
    }

}

public struct PlaceholderView: View {
    
    @Environment(\.colorScheme) var scheme: ColorScheme

    var image: String
    var text: String
    var foregoundColor: Color?
    
    public init(image: String, text: String, foregroundColor: Color? = nil) {
        self.image = image
        self.text = text
        self.foregoundColor = foregroundColor
    }

    public var body: some View {
        VStack {
            Image(self.image).resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100).padding(.bottom, 20.0)
            Text(self.text).foregroundColor(self.foregoundColor ?? BBColor.Text.main.getColor(scheme: scheme)).font(.headline).bold()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(x: 0, y: -60)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaceholderView(image: "boutique", text: "Boutique list is empty")
            PlaceholderOverlay(image: "boutique", text: "Boutique list is empty", isLoading: true, showPlaceholderCondition: true)
        }
    }
}
