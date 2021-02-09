//
//  SearchCoordinator.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//
import UIKit

class PhotoSearchCoordinator: CoordinatorType {
    weak var parantCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType]?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        childCoordinators = [CoordinatorType]()
    }
    
    func start() {
        let photoSearchViewController = PhotoSearchViewController()
        photoSearchViewController.coordinator = self
        
        // TODO: - modal 방식의 변화
        navigationController?.pushViewController(photoSearchViewController, animated: true)
    }
    
    // TODO: - ChildCoordinator 삭제요망
    
    func createPhotoDetailViewController(photos: [PhotoModel], currentIndex: Int) {
        let childCoordinator = PhotoDetailCoordinator(navigationController: navigationController, photos: photos, currentIndex: currentIndex)
        
        childCoordinator.start()
        childCoordinators?.append(childCoordinator)
    }
}
