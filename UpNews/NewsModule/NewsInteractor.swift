//
//  NewsInteractor.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import UIKit

final class NewsInteractor: NewsBusinessLogic, ArticleDataStore {
    // MARK: - Fields
    private let presenter: NewsPresentationLogic
    private let newsService: NewsWorker
    
    // MARK: - Properties
    var articles: [Article] = [] {
        didSet {
            presenter.presentNews(articles: articles)
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic, newsService: NewsWorker) {
        self.presenter = presenter
        self.newsService = newsService
    }
    
    // MARK: - Methods
    func loadFreshNews() {
        newsService.fetchNews(
            for: NewsAddress(
                rubricId: 4,
                pageSize: 8,
                pageIndex: 2
            )
        ) { response in

            switch response {
            case .success(let response):
                guard var response else {
                    print("-1")
                    return
                }
                
                response.passTheRequestId()
                print(response)
            case .failure:
                print("0")
            }
        }
    }
    
    func loadMoreNews() {
        
    }
}
