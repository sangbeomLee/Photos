//
//  PhotosModel.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

struct PhotosModel {
    let id: String
    let thumbUrl: URL?
    let regularUrl: URL?
    let isSponsor: Bool
    let userName: String
    var thumbImage: UIImage? = nil
    
    init(response: PhotosResponse) {
        id = response.id
        thumbUrl = URL(string: response.urls.thumb)
        regularUrl = URL(string: response.urls.regular)
        isSponsor = response.sponsorship != nil
        userName = response.user.name
    }
}
