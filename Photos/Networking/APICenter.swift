//
//  APICenter.swift
//  Photos
//
//  Created by 이상범 on 2021/02/10.
//

import UIKit

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
    // TODO: - 좀 더 간결하게 할 수 있을 것 같다. -> enum QueryItems 만들어서 간결하게 가능할듯
    static func getPhotosRequest(page: Int = 1, per_page: Int = 10) -> URLRequest? {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(per_page)),
            keyQueryItem
        ]
        
        guard let url = url(path: API.photos.path, queryItems: queryItems) else { return nil }
        
        return URLRequest(url: url)
    }
    
    static func getSearchPhotosRequest(for query: String, page: Int = 1, per_page: Int = 10) -> URLRequest? {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: String(query)),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(per_page)),
            keyQueryItem
        ]
        
        guard let url = url(path: API.search.path, queryItems: queryItems) else { return nil }
        
        return URLRequest(url: url)
    }
}

private extension APICenter {
    static let apiKey = APIKey.key
    static let host = "api.unsplash.com"
    
    static var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        
        return components
    }
    
    static var keyQueryItem: URLQueryItem {
        URLQueryItem(name: "client_id", value: APIKey.key)
    }
    
    static func url(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = baseUrlComponents
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
