//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/27.
//

import Foundation
import UIKit

extension UIView {
    
    public enum GradientType {
        case vertical
        case horizontal
        case cross
    }
    
    public func applyGradient(colors: [UIColor], type: GradientType) {
        var endPoint: CGPoint!
        switch (type) {
        case .horizontal:
            endPoint = CGPoint(x: 1, y: 0)
        case .vertical:
            endPoint = CGPoint(x: 0, y: 1)
        case .cross:
            endPoint = CGPoint(x: 1, y: 1)
        }
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = endPoint
        //self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    public func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
