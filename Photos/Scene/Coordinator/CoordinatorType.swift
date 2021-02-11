//
//  CoordinatorType.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

protocol CoordinatorType: AnyObject {
    var parantCoordinator: CoordinatorType? { get set }
    var childCoordinators: [CoordinatorType]? { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
}

extension CoordinatorType {
    func showAlert() {
        let errorAlert = ErrorAlertController.make()
        navigationController?.present(errorAlert, animated: true, completion: nil)
    }
}
