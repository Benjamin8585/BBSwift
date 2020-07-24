//
//  Banner.swift
//  BannersSwiftUI
//
//  Created by Jean-Marc Boullianne on 11/30/19.
//  Copyright © 2019 Jean-Marc Boullianne. All rights reserved.
//

import SwiftUI

public struct BannerData {
    var title: String
    var detail: String
    var type: BannerType
    
    public init(title: String, detail: String, type: BannerType) {
        self.title = title
        self.detail = detail
        self.type = type
    }

    static public var empty: BannerData {
        BannerData(title: "", detail: "", type: .info)
    }
}

public protocol BannerTypeRepresentable {
    
    var tintColor: Color { get }
}

public enum BannerType: BannerTypeRepresentable {
    
    case info
    case warning
    case success
    case error

    public var tintColor: Color {
        switch self {
        case .info:
            return BBColor.Banner.blue
        case .success:
            return BBColor.Banner.green
        case .warning:
            return BBColor.Banner.yellow
        case .error:
            return BBColor.Banner.red
        }
    }
}

public struct BannerModifier: ViewModifier {

    @Binding var data: BannerData
    @Binding var show: Bool

    public func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    Spacer()
                }
                .padding()
                .animation(.easeInOut)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.show = false
                        }
                    }
                })
            }
        }
    }

}

struct BannerContentView: View {

    @State var showBanner: Bool = true
    @State var bannerData: BannerData = BannerData(title: "Title", detail: "Detail", type: .info)
    // Also Supports Banner Types .Success, .Warning, .Error
    var body: some View {
        Text("Hello Trailing Closure")
            .banner(data: $bannerData, show: $showBanner)
            // Simply add the Banner to your root view, and control it using State variables.
    }
}

//struct Banner_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            BannerContentView()
//        }
//    }
//}
