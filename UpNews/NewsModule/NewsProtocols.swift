//
//  NewsModule.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

protocol NewsBusinessLogic {
    func loadStart()
    func loadFreshNews()
    func loadMoreNews()
}

protocol NewsPresentationLogic {
    func presentStart()
}

protocol ArticleDataStore {
    var articles: [String] { get set }
}
