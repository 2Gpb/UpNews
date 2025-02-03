//
//  NewsModule.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import Foundation
import UIKit

protocol NewsBusinessLogic: UITableViewDataSource {
    func loadStart()
    func loadFreshNews()
    func loadWebView(_ index: Int)
    func loadActivityController(_ index: Int)
}

protocol NewsPresentationLogic {
    func presentNews()
}

protocol NewsRouterLogic {
    func routeToWeb(with url: URL)
    func routeToActivityController(with url: URL?)
}

protocol ArticleDataStore {
    var articles: [Article.Response]? { get set }
}

protocol NewsWorker {
    func fetchNews(for address: NewsAddress, completion: ((Result<NewsPage?, Error>) -> Void)?)
}
