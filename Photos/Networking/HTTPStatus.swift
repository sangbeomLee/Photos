//
//  HTTPStatus.swift
//  Photos
//
//  Created by 이상범 on 2021/02/12.
//

import Foundation

enum HTTPStatus: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case serverError = 500
    
    var code: Int {
        rawValue
    }
}
