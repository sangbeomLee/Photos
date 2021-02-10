//
//  PhotosCoordinator.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

protocol PhotosCoordinatorDelegate: AnyObject {
    // TODO: - naming 고민
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
        guard let photosViewController = PhotosViewController.instantiatingFromNib() else {
            // TODO: Error 처리
            print("error: PhotosCoordinator Error")
            return
        }
        
        photosViewController.coordinator = self
        
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    // TODO: - ChildCoordinator 삭제요망
    
    func createPhotoDetailViewController(storage: Storage, currentIndex: Int) {
        let photoDetailViewController = PhotoDetailViewController()
        photoDetailViewController.coordinator = self
        photoDetailViewController.setPhotos(storage, now: currentIndex)
        
        // TODO: - modal 방식의 변화
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
    
    func removePhotoDetailViewController(storage: Storage, currentIndex: Int) {
        navigationController?.popViewController(animated: true)
        
        delegate?.detailViewControllerDidDisappear(storage: storage, index: currentIndex)
    }
}
