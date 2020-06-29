//
//  PlaceholderOverlay.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public struct PlaceholderOverlay: View {

    var image: String
    var text: String
    var isLoading: Bool
    var showPlaceholderCondition: Bool

    public var body: some View {
        ZStack {
            Group {
                if !isLoading && !showPlaceholderCondition {
                    EmptyView()
                } else {
                    Color.white.opacity(!isLoading && !showPlaceholderCondition ? 0 : 1)
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

    var image: String
    var text: String

    public var body: some View {
        VStack {
            Image(self.image).resizable().frame(width: 100, height: 100).padding(.bottom, 20.0)
            Text(self.text).foregroundColor(BBColor.Text.lightBlack).font(.headline).bold()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(x: 0, y: -60).background(Color.white)
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
