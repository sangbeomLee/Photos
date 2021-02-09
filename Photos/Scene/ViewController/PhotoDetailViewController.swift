//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    weak var coordinator: PhotoDetailCoordinator?
    
    private var photos: [PhotoModel] = []
    private var currentIndex: Int = 0

    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setPhotos(_ photos: [PhotoModel], now currentIndex: Int) {
        self.photos = photos
        self.currentIndex = currentIndex
        
        photoImageView.image = photos[currentIndex].thumbImage
    }
}

private extension PhotoDetailViewController {
    func setupView() {
        setupNavigationController()
        setupLayout()
    }
    
    func setupNavigationController() {

    }
    
    func setupLayout() {
        view.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}
