//
//  NewsWorker.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import Foundation
import UIKit

final class NewsService: NewsWorker {
    private let networking: NetworkingLogic
    private let decoder: JSONDecoder = JSONDecoder()
    
    init(networking: NetworkingLogic) {
        self.networking = networking
    }
    
    func fetchNews(
        for address: NewsAddress,
        completion: ((Result<NewsPage?, Error>) -> Void)?
    ) {
        let endpoint = NewsEndpoint.section(
            rubricId: address.rubricId,
            pageSize: address.pageSize,
            pageIndex: address.pageIndex
        )
        
        fetch(request: Request(endpoint: endpoint, timeInterval: 5), completion: completion)
    }
    
    func loadImage(_ imageUrl: URL?) -> UIImage? {
        guard let url = imageUrl,
              let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
        
    private func fetch<T: Decodable>(
        request: Request,
        completion: ((Result<T?, Error>) -> Void)?
    ) {
        networking.execute(with: request) { [weak self] response in
            switch response {
            case .success(let serverResponse):
                guard
                    let self,
                    let data = serverResponse.data
                else {
                    completion?(.success(nil))
                    return
                }
                
                do {
                    let decoded = try self.decoder.decode(T.self, from: data)
                    completion?(.success(decoded))
                } catch {
                    completion?(.failure(error))
                }
                
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
