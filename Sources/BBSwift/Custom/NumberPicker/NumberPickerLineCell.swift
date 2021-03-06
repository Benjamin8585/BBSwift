//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/27.
//

import Foundation

#if os(iOS)
import UIKit

public class NumberPickerLineCell: UICollectionViewCell {
    
    public let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lineView)
    }
    
    public func calcLineViewHeight(_ index: Int, bgColor: UIColor) {
        if index % 5 == 0 {
            lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 80)
            lineView.backgroundColor = bgColor
            
        } else {
            lineView.frame = CGRect(x: 0, y: 15, width: bounds.width, height: 50)
            lineView.backgroundColor = bgColor.withAlphaComponent(0.7)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

#endif
