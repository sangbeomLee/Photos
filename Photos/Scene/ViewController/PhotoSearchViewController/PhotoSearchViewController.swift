//
//  PhotoSearchViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class PhotoSearchViewController: UIViewController {
    weak var coordinator: PhotoSearchCoordinator? {
        didSet {
            coordinator?.delegate = self
        }
    }
    
    private let searchView: SearchView = SearchView.make()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private var storage = SearchPhotoStorage()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupStorage()
        setupLayout()
    }
}

private extension PhotoSearchViewController {
    func setupView() {
        setupNavigationView()
        setupSearchView()
        setupTableView()
    }
    
    func setupNavigationView() {
        // TODO: - navigationBar 말고 위에 상태창도 사라져버렸다. 해결하자
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupSearchView() {
        searchView.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
        // TODO: - self sizing 에 문제가 있다. 이를 해결하자.
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setupLayout() {
        view.addSubview(searchView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupStorage() {
        storage.delegate = self
    }
}

extension PhotoSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let photo = storage.photoFromList(at: indexPath.row), let image = photo.thumbImage else { return 0 }
        
        return tableView.frame.size.width * image.cropRatio
    }
}

// MARK: - UITableViewDataSource

extension PhotoSearchViewController: UITableViewDataSource {
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
        
        // TODO: - 데이터 받아오면 configure 해주기
        cell.configure(by: photo)

        return cell
    }
}

// TODO: - Delegate 가 너무 많다..! 이 친구는 block property 로 변경하자.
extension PhotoSearchViewController: SearchViewDelegate {
    func searchButtonDidTapped(text: String?) {
        guard let query = text else { return }
        
        storage.fetchSearchPhotos(with: query)
    }
}

extension PhotoSearchViewController: StorageDelegate {
    func didFinishFetchPhotos() {
        tableView.reloadData()
    }
}

extension PhotoSearchViewController: PhotoSearchCoordinatorDelegate {
    func detailViewControllerDidDisappear(storage: Storage, index: Int) {
        guard let storage = storage as? SearchPhotoStorage else { return }
        
        self.storage = storage
        storage.delegate = self
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(item: index, section: 0), at: .middle, animated: false)
        
        navigationController?.hidesBarsOnSwipe = true
        tabBarController?.tabBar.isHidden = false
    }
}
