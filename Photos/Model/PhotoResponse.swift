//
//  PhotosResponse.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import Foundation

struct SearchPhotoResponse: Codable {
    let results: [PhotoResponse]
}

// TODO: - updated_at 을 활용 해 보자.
struct PhotoResponse: Codable {
    let id: String
    let urls: Urls
    let sponsorship: Sponsorship?
    let user: User
    
    struct Urls: Codable {
        let regular: String
        let thumb: String
    }
    
    struct Sponsorship: Codable {}
    
    struct User: Codable {
        let name: String
    }
}
