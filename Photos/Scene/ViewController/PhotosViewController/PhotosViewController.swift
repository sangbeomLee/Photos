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
    var photos: [PhotoModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
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
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
        // TODO: - self sizing 에 문제가 있다. 이를 해결하자.
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func fetchData() {
        PhotoAPIProvider.shared.fetchPhotos {[weak self] result in
            switch result {
            // TODO: - 여기서 어떻게 해야하나..? 흠... 다른 사람들은 어떤식으로 진행하는지 내일 찾아보자.
            // TODO: - 해야 할 일 쭈욱 나열하기. -> 내일은 전체적인 완성이 되어야한다.
            case .success(let photos):
                self?.photos = photos
            case .failure(let error):
                // TODO: - Error 처리
                print(error)
            }
        }
    }
}


extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = photos[indexPath.row].thumbImage else { return 0 }
        
        return tableView.frame.size.width * image.cropRatio
    }
}

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
            // TODO: 오류처리
            return UITableViewCell()
        }

        // TODO: - 데이터 받아오면 configure 해주기
        cell.configure(by: photos[indexPath.row])

        return cell
    }
}
