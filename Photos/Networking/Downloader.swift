//
//  Downloader.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//
import Foundation

enum DownloaderError: Error {
    case responseError
    case unownedError
    
    var description: String {
        switch self {
        case .responseError:
            return "다운로드 중 잘못된 응답을 받았습니다."
        case .unownedError:
            return "다운로드 중 알수없는 오류가 있습니다."
        }
    }
}

class Downloader {
    typealias DownloadedDataResult = Result<Data, Error>
    
    static var shared = Downloader()
    
    private let session: URLSession
    
    init (session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func downloadData(from request: URLRequest, completion: @escaping (DownloadedDataResult) -> ()) {
        self.session.dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                completion(DownloadedDataResult.failure(DownloaderError.unownedError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HTTPStatus.success.code else {
                completion(DownloadedDataResult.failure(DownloaderError.responseError))
                return
            }
            
            guard let data = data else {
                completion(DownloadedDataResult.failure(DownloaderError.unownedError))
                return
            }
            
            completion(DownloadedDataResult.success(data))
        }.resume()
    }
}
