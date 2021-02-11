//
//  PhotoStorage.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class PhotoStorage: Storage {
    override init() {
        super.init()
        
        fetchPhotos()
    }
 
    override func photoFromList(at index: Int) -> PhotoModel? {
        if sholudDownloadNextPage(index: index), !isFetching {
            fetchPhotos()
        }
        
        return index > lastIndex ? nil : photos[index]
    }
    
    func fetchPhotos() {
        isFetching = true
        PhotoAPIProvider.shared.fetchPhotos(nextPage) {[weak self] result in
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
