//
//  Downloader.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import Foundation

import UIKit

enum DownloaderError: Error {
    case dataError
    case responseError
    case fetchError
}

public class Downloader {
    typealias DownloadedDataResult = Result<Data, Error>
    
    static var shared = Downloader()
    
    private let session: URLSession
    
    init (session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // TODO: - Request 를 통한 download 만들기.
    func downloadData(from request: URLRequest, completion: @escaping (DownloadedDataResult) -> ()) {
        self.session.dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                completion(DownloadedDataResult.failure(DownloaderError.fetchError))
                return
            }

            // TODO: - HTTPResponse 관련 추가 개선
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(DownloadedDataResult.failure(DownloaderError.responseError))
                return
            }
            
            guard let data = data else {
                completion(DownloadedDataResult.failure(DownloaderError.dataError))
                return
            }
            
            completion(DownloadedDataResult.success(data))
        }.resume()
    }
}
