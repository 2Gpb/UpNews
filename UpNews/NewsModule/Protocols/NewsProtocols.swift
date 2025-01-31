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
    func presentNews(articles: [ArticleModel])
}

protocol ArticleDataStore {
    var articles: [ArticleModel] { get set }
}

protocol NewsWorker {
    
}
