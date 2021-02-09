//
//  PhotoNetworkManager.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

enum APIError: Error {
    case parseJsonError
    case downloadImageError
}

// TODO: - page=?_
enum PhotoAPI {
    case page
    
    static let baseUrl = "https://api.unsplash.com/"
    var path: String { "photos" }
    var url: URL { URL(string: PhotoAPI.baseUrl + path + "/?page=1&per_page=20&client_id=\(APIKey.key)")! }
}

class PhotoAPIProvider {
    typealias FetchResult<T> = Result<T, Error>
    
    static let shared = PhotoAPIProvider(downloader: Downloader.shared)
    
    private var downloader: Downloader
    
    init(downloader: Downloader) {
        self.downloader = downloader
    }
    
    func fetchPhotos(completion: @escaping (FetchResult<[PhotosModel]>) -> Void) {
        // TODO: - 보완할 것 request 만드는 것 따로 정의하자
//        var request = URLRequest(url: PhotoAPI.page.url)
//        let tokenId = APIKey.key
//        let authorizationKey = "client_id".appending(tokenId)
//        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        let request = URLRequest(url: PhotoAPI.page.url)
        
        fetch(request) { (result: FetchResult<[PhotosResponse]>) in
            switch result {
            case .success(let photosResponse):
                // TODO: - 뭔가 photosModels 어감이 이상하다. naming 개선 해 보자
                let photosModels = photosResponse.map { PhotosModel(response: $0) }
                DispatchQueue.main.async {
                    completion(FetchResult.success(photosModels))
                }
            case .failure(let error):
                completion(FetchResult.failure(error))
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (FetchResult<UIImage>) -> Void) {
        downloader.downloadData(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        completion(FetchResult.success(image))
                    } else {
                        completion(FetchResult.failure(APIError.downloadImageError))
                    }
                case .failure(let error):
                    completion(FetchResult.failure(error))
                }
            }
        }
    }
}

private extension PhotoAPIProvider {
    func fetch<T: Codable>(_ request: URLRequest, completion: @escaping (FetchResult<T>) -> Void) {
        downloader.downloadData(from: request) {[weak self] downloadedDataResult in
            switch downloadedDataResult {
            case .success(let data):
                if let decodedData: T = self?.parseJson(for: data) {
                    completion(FetchResult.success(decodedData))
                } else {
                    completion(FetchResult.failure(APIError.parseJsonError))
                }
            case .failure(let error):
                // TODO: - error 처리
                print(error)
            }
        }
    }
}

// MARK: - ParseJson

private extension PhotoAPIProvider {
    func parseJson<T: Codable>(for data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
