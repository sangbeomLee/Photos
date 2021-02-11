//
//  StorageType.swift
//  Photos
//
//  Created by 이상범 on 2021/02/10.
//

import UIKit

protocol StorageDelegate: AnyObject {
    func didFinishFetchPhotos(error: Error?)
}

class Storage {
    weak var delegate: StorageDelegate?
    
    var photos: [PhotoModel] = []
    var currentPage: Int = 0
    var lastIndex: Int {
        photos.count - 1
    }
    
    var nextPage: Int {
        currentPage + 1
    }
    
    var count: Int {
        photos.count
    }
  
    func sholudDownloadNextPage(index: Int) -> Bool {
        return lastIndex - 5 <= index
    }
    
    func store(_ photos: [PhotoModel]) {
        self.photos.append(contentsOf: photos)
        currentPage += 1
    }
    
    func removeAll() {
        photos.removeAll()
        currentPage = 0
    }
    
    // TODO: - 겹친다 더 나은 방법을 생각 해 보자.
    func photoList() -> [PhotoModel] {
        return photos
    }
    
    func photoFromList(at index: Int) -> PhotoModel? {
        return index > lastIndex ? nil : photos[index]
    }
}
