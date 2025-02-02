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
    func presentNews() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayNews()
        }
    }
}

// MARK: - NewsRouterLogic
extension NewsPresenter: NewsRouterLogic {
    func routeToWebView(with url: URL?) {
        let webView = WebViewAssembly.build(with: url)
        view?.navigationController?.pushViewController(webView, animated: true)
    }
    
    func routeToActivityController(with url: URL?) {
        let activityController = UIActivityViewController(activityItems: [url ?? ""], applicationActivities: nil)
        view?.navigationController?.present(activityController, animated: true)
    }
}
