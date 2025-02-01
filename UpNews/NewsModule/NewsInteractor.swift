//
//  NewsInteractor.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import UIKit

final class NewsInteractor: NSObject, NewsBusinessLogic, ArticleDataStore {
    // MARK: - Fields
    private let presenter: NewsPresentationLogic
    private let newsService: NewsWorker
    
    // MARK: - Properties
    var articles: [Article.Response]? = [] // {
//        didSet {
//            presenter.presentNews(response: articles)
//        }
//    }
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic, newsService: NewsWorker) {
        self.presenter = presenter
        self.newsService = newsService
    }
    
    // MARK: - Methods
    func loadFreshNews() {
        newsService.fetchNews(
            for: NewsAddress(
                rubricId: 4,
                pageSize: 8,
                pageIndex: 2
            )
        ) { [weak self] response in

            switch response {
            case .success(let response):
                guard var response else {
                    print("-1")
                    return
                }
                
                response.passTheRequestId()
                self?.article(response: response)
            case .failure:
                print("0")
            }
        }
    }
    
    private func article(response: NewsPage) {
        if let articles = response.news {
            DispatchQueue.global().async { [weak self] in
                for article in articles {
                    self?.articles?.append(
                        Article.Response(
                            title: article.title,
                            announce: article.announce,
                            img: self?.newsService.loadImage(article.img?.url),
                            articleUrl: article.articleUrl
                        )
                    )
                }
                self?.presenter.presentNews(response: self?.articles ?? [])
            }
        }
    }
}

extension NewsInteractor {
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
                img: articles?[indexPath.row].img ?? UIImage()
            )
        
        print(articles?[indexPath.row].articleUrl ?? "")
        
        return cell
    }
}
