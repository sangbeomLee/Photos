//
//  PhotosModel.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

struct PhotoModel {
    let id: String
    let url: URL?
    let isSponsor: Bool
    let userName: String
    var image: UIImage? = nil
    
    init(response: PhotoResponse) {
        id = response.id
        url = URL(string: response.urls.regular)
        isSponsor = response.sponsorship != nil
        userName = response.user.name
    }
}
