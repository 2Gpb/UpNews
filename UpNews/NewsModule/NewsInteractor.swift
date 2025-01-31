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
    
    // MARK: - Properties
    var articles: [ArticleModel] = [] {
        didSet {
            presenter.presentNews(articles: articles)
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadFreshNews() {
        
    }
    
    func loadMoreNews() {
        
    }
}
