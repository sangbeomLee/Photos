//
//  PhotoSearchViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class PhotoSearchViewController: UIViewController {
    weak var coordinator: PhotoSearchCoordinator?
    
    private let searchView: SearchView = SearchView.make()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private var storage = PhotoStorage()
    var photos: [PhotoModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
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
    
    func fetchData(with query: String?) {
//        guard let query = query else { return }
//        let page = storage.nextPage
//        storage.lastIndex += 10
//        
//        PhotoAPIProvider.shared.fetchSearchPhotos(for: query, page: page) {[weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let photos):
//                self.storage.store(photos)
//                self.photos = self.storage.photoList()
//            case .failure(let error):
//                // TODO: - Error 처리
//                print(error)
//            }
//        }
    }
}

extension PhotoSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = photos[indexPath.row].thumbImage else { return 0 }
        
        return tableView.frame.size.width * image.cropRatio
    }
}

// MARK: - UITableViewDataSource

extension PhotoSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.createPhotoDetailViewController(storage: storage, currentIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
            // TODO: 오류처리
            return UITableViewCell()
        }
        let index = indexPath.row
        if storage.sholudDownloadNextPage(index: index) {
            fetchData(with: searchView.text)
        }
        
        // TODO: - 데이터 받아오면 configure 해주기
        cell.configure(by: photos[indexPath.row])

        return cell
    }
}

extension PhotoSearchViewController: SearchViewDelegate {
    func searchButtonDidTapped(text: String?) {
        guard let query = text else { return }
        
        PhotoAPIProvider.shared.fetchSearchPhotos(for: query, page: 1) { result in
            switch result {
            case .success(let photos):
                if photos.isEmpty {
                    // TODO: - search 결과가 없습니다. 띄우기
                } else {
                    self.photos = photos
                }
            case .failure(let error):
                // TODO: - Error
                print(error)
            }
        }
    }

}
