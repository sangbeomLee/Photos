//
//  PhotosCoordinator.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

protocol PhotosCoordinatorDelegate: AnyObject {
    func detailViewControllerDidDisappear(storage: Storage, index: Int)
}

class PhotosCoordinator: CoordinatorType {
    weak var delegate: PhotosCoordinatorDelegate?
    weak var parantCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType]?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        childCoordinators = [CoordinatorType]()
    }
    
    func start() {
        guard let photosViewController = PhotosViewController.instantiatingFromNib() else { return }
        photosViewController.coordinator = self
        
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    func createPhotoDetailViewController(storage: Storage, currentIndex: Int) {
        let photoDetailViewController = PhotoDetailViewController()
        photoDetailViewController.coordinator = self
        photoDetailViewController.setPhotos(storage, now: currentIndex)
        
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
    
    func removePhotoDetailViewController(storage: Storage, currentIndex: Int) {
        navigationController?.popViewController(animated: true)
        
        delegate?.detailViewControllerDidDisappear(storage: storage, index: currentIndex)
    }
}
