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
    case requestError
}

class PhotoAPIProvider {
    typealias FetchResult<T> = Result<T, Error>
    
    static let shared = PhotoAPIProvider(downloader: Downloader.shared)
    
    private var downloader: Downloader
    
    init(downloader: Downloader) {
        self.downloader = downloader
    }
    
    func fetchPhotos(completion: @escaping (FetchResult<[PhotoModel]>) -> Void) {
        guard let request = APICenter.getPhotosRequest() else {
            completion(FetchResult.failure(APIError.requestError))
            return
        }

        fetch(request) {[weak self] (result: FetchResult<[PhotoResponse]>) in
            switch result {
            case .success(let photosResponse):
                // TODO: - 뭔가 photosModels 어감이 이상하다. naming 개선 해 보자
                let photoModels = photosResponse.map { PhotoModel(response: $0) }
                self?.downloadImages(for: photoModels) { photoModels in
                    DispatchQueue.main.async {
                        completion(FetchResult.success(photoModels))
                    }
                }
            case .failure(let error):
                completion(FetchResult.failure(error))
            }
        }
    }
    
    func fetchSearchPhotos(for text: String, completion: @escaping (FetchResult<[PhotoModel]>) -> Void) {
        guard let request = APICenter.getSearchPhotosRequest(for: text) else {
            completion(FetchResult.failure(APIError.requestError))
            return
        }

        fetch(request) {[weak self] (result: FetchResult<SearchPhotoResponse>) in
            switch result {
            case .success(let searchPhotoResponse):
                // TODO: - 뭔가 photosModels 어감이 이상하다. naming 개선 해 보자
                let photoModels = searchPhotoResponse.results.map { PhotoModel(response: $0) }
                self?.downloadImages(for: photoModels) { photoModels in
                    DispatchQueue.main.async {
                        completion(FetchResult.success(photoModels))
                    }
                }
            case .failure(let error):
                completion(FetchResult.failure(error))
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
    
    // Download image 까지 완료 한 후 반환한다.
    func downloadImages(for photoModels: [PhotoModel], completion: @escaping ([PhotoModel]) -> Void) {
        var photoModels = photoModels
        let dispatchGroup = DispatchGroup()
        
        photoModels.enumerated().forEach {[weak self] (index, photo) in
            // TODO: - 없을때 처리 -> 딱히 안해줘도 되려나
            guard let url = photo.regularUrl else { return }
            
            dispatchGroup.enter()
            self?.downloadImage(from: url) { result in
                switch result {
                case .success(let image):
                    photoModels[index].thumbImage = image
                case .failure(let error):
                    // TODO: - Error
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
        
        // TODO: - .main 어떤것인지 알기.
        dispatchGroup.notify(queue: .main) {
            completion(photoModels)
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

// MARK: - ParseJson

private extension PhotoAPIProvider {
    func parseJson<T: Codable>(for data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
