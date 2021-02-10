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
        if sholudDownloadNextPage(index: index) {
            fetchPhotos()
        }
        
        return index > lastIndex ? nil : photos[index]
    }
    
    func fetchPhotos() {
        let page = nextPage
        // TODO: - storage.lastIndex 이부분 변경
        lastIndex += 10
        
        PhotoAPIProvider.shared.fetchPhotos(page) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                self.store(photos)
            case .failure(let error):
                // TODO: - Error 처리
                print(error)
            }
            
            self.delegate?.didFinishFetchPhotos()
        }
    }
}
