//
//  PhotosViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

private enum Constant {
    static var navigationTitle: String { "PHOTOS" }
    static let cellName: String = "PhotosTableViewCell"
    static let cellIdentifier: String = "PhotosTableViewCell"
}

class PhotosViewController: UIViewController {
    weak var coordinator: PhotosCoordinator? {
        didSet {
            coordinator?.delegate = self
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    private var storage = PhotoStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupView()
        setupStorage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

// MARK: - Setup

private extension PhotosViewController {
    func setupView() {
        setupNavigation()
        setupTableView()
    }
    
    func setupNavigation() {
        navigationItem.title = Constant.navigationTitle
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constant.cellName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
    }
    
    func setupStorage() {
        storage.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let photo = storage.photos(at: indexPath.row), let image = photo.image else { return 0 }
        
        return tableView.frame.size.width * image.cropRatio
    }
}

// MARK: - UITableViewDataSource

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.createPhotoDetailViewController(storage: storage, currentIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as? PhotosTableViewCell,
              let photo = storage.photos(at: indexPath.row) else {
            return UITableViewCell()
        }

        cell.configure(by: photo)

        return cell
    }
}

// MARK: - StorageDelegate

extension PhotosViewController: StorageDelegate {
    func didFinishFetchPhotos(error: Error?) {
        guard error == nil else {
            coordinator?.showAlert(with: error)
            return
        }

        if !loadingView.isHidden {
            loadingView.isHidden = true
        }

        tableView.reloadData()
    }
}

// MARK: - PhotosCoordinatorDelegate

extension PhotosViewController: PhotosCoordinatorDelegate {
    func detailViewControllerDidDisappear(storage: Storage, index: Int) {
        guard let storage = storage as? PhotoStorage else { return }
        
        self.storage = storage
        storage.delegate = self
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(item: index, section: 0), at: .middle, animated: false)
        
        navigationController?.hidesBarsOnSwipe = true
        tabBarController?.tabBar.isHidden = false
    }
}
