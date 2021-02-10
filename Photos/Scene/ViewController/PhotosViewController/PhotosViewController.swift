//
//  PhotosViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

class PhotosViewController: UIViewController {
    weak var coordinator: PhotosCoordinator?

    @IBOutlet weak var tableView: UITableView!
    // TODO: - Storage 만들어 관리하기
    private var storage = PhotoStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupStorage()
    }
}

private extension PhotosViewController {
    func setupView() {
        setupNavigation()
        setupTableView()
    }
    
    func setupNavigation() {
        navigationItem.title = "PHOTOS"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        // TODO: - Font 추가
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setupStorage() {
        storage.delegate = self
    }
}


extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let photo = storage.photoFromList(at: indexPath.row), let image = photo.thumbImage else { return 0 }
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell,
              let photo = storage.photoFromList(at: indexPath.row) else {
            // TODO: 오류처리
            return UITableViewCell()
        }

        cell.configure(by: photo)

        return cell
    }
}

extension PhotosViewController: StorageDelegate {
    func didFinishFetchPhotos() {
        tableView.reloadData()
    }
}
