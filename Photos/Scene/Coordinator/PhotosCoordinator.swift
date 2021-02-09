//
//  PhotosCoordinator.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

class PhotosCoordinator: CoordinatorType {
    weak var parantCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType]?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        childCoordinators = [CoordinatorType]()
    }
    
    func start() {
        guard let photosViewController = PhotosViewController.instantiatingFromNib() else {
            // TODO: Error 처리
            print("error: PhotosCoordinator Error")
            return
        }
        
        photosViewController.coordinator = self
        
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    func createPhotoDetailViewController(photos: [PhotoModel], currentIndex: Int) {
        let childCoordinator = PhotoDetailCoordinator(navigationController: navigationController, photos: photos, currentIndex: currentIndex)
        
        childCoordinator.start()
        childCoordinators?.append(childCoordinator)
    }
}
