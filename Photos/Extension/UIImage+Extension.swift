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
}
