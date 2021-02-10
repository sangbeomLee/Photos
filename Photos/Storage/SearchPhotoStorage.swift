//
//  PhotoStorage.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class SearchPhotoStorage: Storage {
    var query: String?
    
    override func photoFromList(at index: Int) -> PhotoModel? {
        if sholudDownloadNextPage(index: index) {
            fetchSearchPhotos(with: query)
        }
        
        return index > lastIndex ? nil : photos[index]
    }
    
    func fetchSearchPhotos(with query: String?) {
        guard let query = query else { return }
        self.query = query
        
        let page = nextPage
        // TODO: - storage.lastIndex 이부분 변경
        lastIndex += 10
        
        PhotoAPIProvider.shared.fetchSearchPhotos(for: query, page: page) {[weak self] result in
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
