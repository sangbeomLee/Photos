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
    func showAlert(with error: Error) {
        let errorAlert = ErrorAlertController.make(with: description(error))
        navigationController?.present(errorAlert, animated: true, completion: nil)
    }
    
    private func description(_ error: Error) -> String {
        let description: String
        
        if let downloaderError = error as? DownloaderError {
            description = downloaderError.description
        } else if let apiError = error as? APIError {
            description = apiError.description
        } else {
            description = error.localizedDescription
        }
        
        return description
    }
}
