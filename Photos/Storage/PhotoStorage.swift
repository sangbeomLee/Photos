//
//  PhotoStorage.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

final class PhotoStorage: Storage {
    let apiProvider = APIProvider.shared
    
    override init() {
        super.init()
        
        fetchPhotos()
    }
 
    override func photos(at index: Int) -> PhotoModel? {
        if sholudDownloadNextPage(index: index), !isFetching {
            fetchPhotos()
        }
        
        return index > lastIndex ? nil : photos[index]
    }
    
    func fetchPhotos() {
        isFetching = true
        
        apiProvider.fetchPhotos(nextPage) {[weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.store(photos)
                    self.delegate?.didFinishFetchPhotos(error: nil)
                case .failure(let error):
                    // TODO: - Error 처리
                    self.delegate?.didFinishFetchPhotos(error: error)
                }
            }
        }
    }
}
