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

        if isNew(query) {
            removeAll()
            self.query = query
        }
        
        PhotoAPIProvider.shared.fetchSearchPhotos(for: query, page: nextPage) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.store(photos)
                    self.delegate?.didFinishFetchPhotos(error: nil)
                case .failure(let error):
                    self.delegate?.didFinishFetchPhotos(error: error)
                }
            } 
        }
    }
    
    private func isNew(_ query: String) -> Bool {
        self.query != query
    }
}
