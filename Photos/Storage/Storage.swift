//
//  StorageType.swift
//  Photos
//
//  Created by 이상범 on 2021/02/10.
//

import UIKit

protocol PhotoStorageDelegate: AnyObject {
    func didFinishFetchPhotos()
}

class Storage {
    weak var delegate: PhotoStorageDelegate?
    
    var photos: [PhotoModel] = []
    var currentPage: Int = 0
    var lastIndex = 0
    
    var nextPage: Int {
        currentPage + 1
    }
    
    var count: Int {
        photos.count
    }
    
    // TODO: - 1시간이 지났다면 다시 데이터를 받는다.
    //private var currentDate = Date()
    
    func sholudDownloadNextPage(index: Int) -> Bool {
        return lastIndex - 5 <= index
    }
    
    func store(_ photos: [PhotoModel]) {
        self.photos.append(contentsOf: photos)
        currentPage += 1
    }
    
    // TODO: - 겹친다 더 나은 방법을 생각 해 보자.
    func photoList() -> [PhotoModel] {
        return photos
    }
    
    func photoFromList(at index: Int) -> PhotoModel? {
        return index > lastIndex ? nil : photos[index]
    }
}
