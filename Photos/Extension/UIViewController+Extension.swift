//
//  UIViewController+Extension.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

extension UIViewController {
    static var className: String {
        String(describing: Self.self)
    }
    
    class func instantiatingFromNib(_ name: String? = nil, bundle: Bundle? = nil) -> Self? {
        let nibName = name ?? className
        
        return instantiatingFromNib(nibName, type: self, bundle: bundle)
    }
    
    private class func instantiatingFromNib<T: UIViewController>(_ nibName: String, type: T.Type, bundle: Bundle?) -> T? {
        T(nibName: nibName, bundle: bundle)
    }
}
