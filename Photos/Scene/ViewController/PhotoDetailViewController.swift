//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    weak var coordinator: CoordinatorType?
    private var storage: Storage?
    
    private var currentIndex: Int? {
        collectionView.indexPathsForVisibleItems.last?.row
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
 
        return collectionView
    }()
    
    private var cancleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cancleIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var cancleButtonBottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
    }
    
    func setPhotos(_ storage: Storage, now currentIndex: Int) {
        self.storage = storage
        storage.delegate = self
    
        // collectionView 의 Cell 이 불리기 전에 옮겨준다.
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}

private extension PhotoDetailViewController {
    func setupView() {
        setupViewController()
        setupNavigationController()
        setupCollectionView()
    }
    
    func setupViewController() {
        view.backgroundColor = .black
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupNavigationController() {
        navigationController?.isNavigationBarHidden = true
        
        navigationController?.hidesBarsOnSwipe = false
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(cancleButton)
        cancleButtonBottomConstraint = cancleButton.bottomAnchor.constraint(equalTo: view.topAnchor)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            cancleButtonBottomConstraint,
            cancleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cancleButton.widthAnchor.constraint(equalToConstant: 20),
            cancleButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoDetailCollectionViewCell")
    }
}

@objc
private extension PhotoDetailViewController {
    func buttonDidTapped(_ button: UIButton) {
        guard let storage = storage, let currentIndex = currentIndex else { return }
        
        if let coordinator = coordinator as? PhotosCoordinator {
            coordinator.removePhotoDetailViewController(storage: storage, currentIndex: currentIndex)
        } else if let coordinator = coordinator as? PhotoSearchCoordinator {
            coordinator.removePhotoDetailViewController(storage: storage, currentIndex: currentIndex)
        } else {
            return
        }
    }
    
    func viewDidTapped() {
        if cancleButtonBottomConstraint.constant == 0 {
            cancleButtonBottomConstraint.constant = view.safeAreaInsets.top + 40
        } else {
            cancleButtonBottomConstraint.constant = 0
        }
        
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension PhotoDetailViewController: UICollectionViewDelegate {}

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selectedItemAt: \(indexPath.row)")
    }
    
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
