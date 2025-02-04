//
//  NewsInteractor.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import UIKit

final class NewsInteractor: NSObject, NewsBusinessLogic, ArticleDataStore {
    // MARK: - Fields
    private let presenter: NewsPresentationLogic & NewsRouterLogic
    private let newsService: NewsWorker
    
    // MARK: - Variables
    var articles: [Article.Response]? = []
    private var isLoading: Bool = false
    private var pagesToLoad: [Int] = Array(repeating: 1, count: 16)
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic & NewsRouterLogic, newsService: NewsWorker) {
        self.presenter = presenter
        self.newsService = newsService
    }
    
    // MARK: - Methods
    func loadStart() {
        if articles?.isEmpty ?? false {
            loadFreshNews()
        }
    }
    
    func loadWebView(_ index: Int) {
        let url = articles?[index].articleUrl ?? URL(fileURLWithPath: "")
        presenter.routeToWeb(with: url)
    }
    
    func loadActivityController(_ index: Int) {
        presenter.routeToActivityController(with: articles?[index].articleUrl)
    }
    
    func loadMoreNews() {
        if isLoading { return }
        isLoading = true
        
        if pagesToLoad.count != 0 {
            loadFreshNews(pageIndex: pagesToLoad.count)
            pagesToLoad.remove(at: pagesToLoad.count - 1)
        }
    }
    
    func refresh() {
        articles?.removeAll()
        loadFreshNews()
    }
    
    // MARK: - Private methods
    private func loadFreshNews(rubric id: Int = 4, numberOfPage pageSize: Int = 12, pageIndex index: Int = 17) {
        newsService.fetchNews(
            for: NewsAddress(
                rubricId: id,
                pageSize: pageSize,
                pageIndex: index
            )
        ) { [weak self] response in

            switch response {
            case .success(let response):
                guard var response else {
                    print("0")
                    self?.isLoading = false
                    return
                }
    
                response.passTheRequestId()
                self?.article(response: response)
            case .failure:
                print("-1")
                self?.isLoading = false
            }
        }
    }
    
    private func article(response: NewsPage) {
        for article in response.news ?? [] {
            self.articles?.append(
                Article.Response(
                    title: article.title,
                    announce: article.announce,
                    imgUrl: article.img?.url,
                    articleUrl: article.articleUrl
                )
            )
        }
        
        presenter.presentNews()
        isLoading = false
    }
}

// MARK: - UITableViewDataSource
extension NewsInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsCell.reuseId,
            for: indexPath
        ) as? NewsCell else {
            return UITableViewCell()
        }
        
        cell.configure(
                title: articles?[indexPath.row].title ?? "",
                description: articles?[indexPath.row].announce ?? "",
                url: articles?[indexPath.row].imgUrl
            )
        
        return cell
    }
}
