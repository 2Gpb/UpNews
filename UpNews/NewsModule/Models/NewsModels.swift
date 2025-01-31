//
//  NewsModels.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import Foundation

// MARK: - NewsPage
struct NewsPage: Codable {
    var requestId: String?
    var news: [Article]?
    
    mutating func passTheRequestId() {
        for index in 0..<(news?.count ?? 0) {
            news?[index].requestId = requestId
        }
    }
}

// MARK: - Article
struct Article: Codable {
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
struct ImageContainer: Codable {
    var url: URL?
}

// MARK: - NewsAddress
struct NewsAddress {
    var rubricId: Int
    var pageSize: Int
    var pageIndex: Int
}
