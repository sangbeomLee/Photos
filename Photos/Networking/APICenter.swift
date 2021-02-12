//
//  APICenter.swift
//  Photos
//
//  Created by 이상범 on 2021/02/10.
//

import UIKit

// MARK: - private enum

private enum Constant {
    static let http: String = "https"
    static let host: String = "api.unsplash.com"
    
    static let perPageCount: Int = 10
}

private enum Query {
    static let page: String = "page"
    static let perPage: String = "perPage"
    static let query: String = "query"
    static let clientId: String = "client_id"
}

private enum API {
    case photos
    case search
    
    var path: String {
        switch self {
        case .photos:
            return "/\(self)"
        case .search:
            return "/\(self)/\(API.photos)"
        }
    }
}

struct APICenter {
    private static let apiKey = APIKey.key
    private static let host = Constant.host
    
    // MARK: - static func
    
    static func getPhotosRequest(page: Int, per_page: Int = Constant.perPageCount) -> URLRequest? {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: Query.page, value: String(page)),
            URLQueryItem(name: Query.perPage, value: String(per_page)),
            keyQueryItem
        ]
        
        guard let url = url(path: API.photos.path, queryItems: queryItems) else { return nil }
        
        return URLRequest(url: url)
    }
    
    static func getSearchPhotosRequest(for query: String, page: Int, per_page: Int = Constant.perPageCount) -> URLRequest? {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: Query.query, value: String(query)),
            URLQueryItem(name: Query.page, value: String(page)),
            URLQueryItem(name: Query.perPage, value: String(per_page)),
            keyQueryItem
        ]
        
        guard let url = url(path: API.search.path, queryItems: queryItems) else { return nil }
        
        return URLRequest(url: url)
    }
    
    static func url(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = baseUrlComponents
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

// MARK: - static var

private extension APICenter {
    static var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = Constant.http
        components.host = host
        
        return components
    }
    
    static var keyQueryItem: URLQueryItem {
        URLQueryItem(name: Query.clientId, value: APIKey.key)
    }
}
