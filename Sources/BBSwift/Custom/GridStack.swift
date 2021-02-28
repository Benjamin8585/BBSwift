//
//  GridStack.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/10/08.
//

import Foundation
import SwiftUI

public struct GridStack<T: Any, Content: View>: View {
    
    public let objects: [T]
    public let columns: Int
    public let content: (Int, Int, T) -> Content
    
    public var rows: Int {
        return Int(ceil(Double(self.objects.count) / Double(self.columns)))
    }
    
    public func getObject(row: Int, column: Int) -> T {
        let index = row * self.columns + column
        return objects[index]
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0 ..< self.rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column, self.getObject(row: row, column: column))
                    }
                    Spacer()
                }
            }
        }
    }

    public init(objects: [T], columns: Int, @ViewBuilder content: @escaping (Int, Int, T) -> Content) {
        self.objects = objects
        self.columns = columns
        self.content = content
    }
}
