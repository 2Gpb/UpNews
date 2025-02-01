//
//  NewsModule.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import Foundation
import UIKit

protocol NewsBusinessLogic: UITableViewDataSource {
    func loadFreshNews()
}

protocol NewsPresentationLogic {
    func presentNews(response: [Article.Response]?)
}

protocol ArticleDataStore {
    var articles: [Article.Response]? { get set }
}

protocol NewsWorker {
    func fetchNews(for address: NewsAddress, completion: ((Result<NewsPage?, Error>) -> Void)?)
    func loadImage(_ imageUrl: URL?) -> UIImage?
}
