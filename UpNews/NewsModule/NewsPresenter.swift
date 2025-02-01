//
//  NewsPresenter.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {
    // MARK: - Variables
    weak var view: NewsViewController?
    
    // MARK: - Methods
    func presentNews(response: [Article.Response]?) {
        var articles: [Article.ViewModel] = []
        for article in response ?? [] {
            articles.append(Article.ViewModel(
                title: article.title,
                announce: article.announce,
                img: article.img,
                articleUrl: article.articleUrl)
            )
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayNews(articles)
        }
    }
}
