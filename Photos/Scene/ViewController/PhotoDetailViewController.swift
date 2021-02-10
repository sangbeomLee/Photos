//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    private var storage: PhotoStorage?
    private var currentIndex: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.invalidateIntrinsicContentSize()
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setPhotos(_ storage: PhotoStorage, now currentIndex: Int) {
        self.storage = storage
        storage.delegate = self
        self.currentIndex = currentIndex
        
        // collectionView 의 Cell 이 불리기 전에 옮겨준다.
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}

private extension PhotoDetailViewController {
    func setupView() {
        setupNavigationController()
        setupLayout()
        setupCollectionView()
    }
    
    func setupNavigationController() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoDetailCollectionViewCell")
    }
}

extension PhotoDetailViewController: UICollectionViewDelegate {}

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let storage = storage else { return 0 }
        
        return storage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoDetailCollectionViewCell", for: indexPath) as? PhotoDetailCollectionViewCell,
              let storage = storage,
              let photo = storage.photoFromList(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        currentIndex = indexPath.row
        cell.configure(with: photo)
        
        return cell
    }
}

extension PhotoDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: view.frame.width, height: view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PhotoDetailViewController: StorageDelegate {
    func didFinishFetchPhotos() {
        collectionView.reloadData()
    }
}
