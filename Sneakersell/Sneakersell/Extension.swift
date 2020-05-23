//
//  Extension.swift
//  Sneakersell
//
//

import Foundation
import UIKit

extension UIView {
    func roundCorner(){
        self.layer.cornerRadius = self.bounds.height * 0.5
    }
    
    func customInputView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.cornerRadius = self.bounds.height * 0.5
    }
}

extension UIButton {
    func btnRoundCorner(){
        self.layer.cornerRadius = self.bounds.height * 0.5
    }
}

extension UIImage {

    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}
