//
//  UIImage+Extension.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

extension UIImage {
    var cropRatio: CGFloat {
        CGFloat(size.height / size.width)
    }
    
    func resizedImage(targetSize: CGSize) -> UIImage? {
        let widthRaito = targetSize.width / size.width
        let heightRaito = targetSize.height / size.height
        let newSize: CGSize
        
        if heightRaito < widthRaito {
            newSize = CGSize(width: size.width * heightRaito, height: size.height * heightRaito)
        } else {
            newSize = CGSize(width: size.width * widthRaito, height: size.height * widthRaito)
        }
        
        let renderFormat = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        let newImage = renderer.image { _ in self.draw(in: rect)}
        
        return newImage
    }
}
