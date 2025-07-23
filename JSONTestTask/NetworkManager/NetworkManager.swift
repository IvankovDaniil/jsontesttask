//
//  NetworkManager.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//
import Alamofire
import Foundation

//MARK: - Работа с JSON
final class NetworkManager {
    static let shared = NetworkManager()
    
    private let session: Session
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5
        config.timeoutIntervalForResource = 5
        self.session = Session(configuration: config)
    }
    
    
    //Метод скачивания с сайта данных
    func fetchPosts(completion: @escaping (Result<[PostDTO], Error>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        session.request(url).validate().responseDecodable(of: [PostDTO].self) { response in
            switch response.result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
