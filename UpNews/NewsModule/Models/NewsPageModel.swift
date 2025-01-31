//
//  NewsModels.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import Foundation

// MARK: - NewsPageModel
struct NewsPageModel {
    var requestId: String?
    var news: [ArticleModel] {
        didSet {
            for index in news.indices {
                news[index].requestId = requestId
            }
        }
    }
}

// MARK: - ArticleModel
struct ArticleModel: Decodable {
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? 0
        return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
    }
}

// MARK: - ImageContainer
struct ImageContainer: Decodable {
    var url: URL?
}
