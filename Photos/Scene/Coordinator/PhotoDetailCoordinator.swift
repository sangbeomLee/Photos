//
//  PhotoDetailCoordinator.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class PhotoDetailCoordinator: CoordinatorType {
    weak var parantCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType]?
    var navigationController: UINavigationController?
    
    var photos: [PhotoModel]
    var currentIndex: Int
    
    init(navigationController: UINavigationController?, photos: [PhotoModel], currentIndex: Int) {
        self.navigationController = navigationController
        childCoordinators = [CoordinatorType]()
        
        self.photos = photos
        self.currentIndex = currentIndex
    }
    
    func start() {
        let photoDetailViewController = PhotoDetailViewController()
        photoDetailViewController.coordinator = self
        photoDetailViewController.setPhotos(photos, now: currentIndex)
        
        // TODO: - modal 방식의 변화
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
}
