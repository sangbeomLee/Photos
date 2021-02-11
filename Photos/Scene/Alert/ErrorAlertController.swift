//
//  ErrorAlertViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/12.
//

import UIKit

final class ErrorAlertController: UIAlertController {
    // TODO: - 어떤 에러인지에 따라 다르게 보여줘야한다.
    static func make() -> ErrorAlertController {
        let alertController = ErrorAlertController(title: "Error", message: "원하는 데이터가 없습니다.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
}
