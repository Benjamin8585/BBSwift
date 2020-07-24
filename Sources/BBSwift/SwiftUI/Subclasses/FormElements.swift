//
//  FormElements.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

/// Create section - native style but with VStack
public struct FormSection<Content>: View where Content: View {
    
    @Environment(\.colorScheme) var scheme: ColorScheme
    
    private let content: Content
    var title: String
    var padding: CGFloat
    var titleBottom: CGFloat
    var titleColor: Color?
    
    public init(title: String, padding: CGFloat = 15.0, titleBottom: CGFloat = 7.0, titleColor: Color? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.padding = padding
        self.titleBottom = titleBottom
        self.titleColor = titleColor
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(self.title).font(.footnote).foregroundColor(self.titleColor ?? BBColor.Text.sectionTitleColor.getColor(scheme: scheme))
                Spacer()
            }.padding(.bottom, self.titleBottom)
            .padding(.leading, self.padding)
            .padding(.trailing, self.padding)
            VStack(spacing: 0) {
                self.content
            }
        }
    }
}

/// Create line - native style to have white rows
public struct FormLine<Content>: View where Content: View {
    
    @Environment(\.colorScheme) var scheme: ColorScheme

    private let content: Content
    var foregroundColor: Color?
    var backgroundColor: Color?
    var height: CGFloat
    var padding: CGFloat
    
    public init(foregroundColor: Color? = nil, backgroundColor: Color? = nil, height: CGFloat = 40.0, padding: CGFloat = 15.0, @ViewBuilder content: () -> Content) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.height = height
        self.padding = padding
        self.content = content()
    }
    
    public var body: some View {
        HStack {
            self.content
        }
        .foregroundColor(self.foregroundColor ?? BBColor.Text.main.getColor(scheme: scheme))
        .frame(minHeight: self.height)
        .padding(.leading, self.padding)
        .padding(.trailing, self.padding)
        .background(self.backgroundColor ?? BBColor.Background.formLine.getColor(scheme: scheme))
    }
}

struct FormSectionContainer: View {
    
    @Environment(\.colorScheme) var scheme: ColorScheme
    
    var body: some View {
        VStack {
            FormSection(title: "This is a section title") {
                FormLine {
                    Text("Cool")
                    Spacer()
                    Text("Cool and small").font(.footnote)
                }
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 15)
        .background(BBColor.Background.form.getColor(scheme: scheme))
    }
    
}


//struct FormSection_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            FormSectionContainer().environment(\.colorScheme, .light)
//            FormSectionContainer().environment(\.colorScheme, .dark)
//        }
//    }
//}
