//
//  NewsModule.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

protocol NewsBusinessLogic {
    func loadFreshNews()
    func loadMoreNews()
}

protocol NewsPresentationLogic {
    func presentNews(articles: [Article])
}

protocol ArticleDataStore {
    var articles: [Article] { get set }
}

protocol NewsWorker {
    func fetchNews(for address: NewsAddress, completion: ((Result<NewsPage?, Error>) -> Void)?)
}
