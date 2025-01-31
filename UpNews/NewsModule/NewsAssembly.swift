//
//  File.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//
import UIKit

enum NewsAssembly {
    // MARK: - Build
    static func build() -> UIViewController {
        let worker = BaseURLWorker(baseUrl: "https://news.myseldon.com")
        let newsService = NewsService(networking: worker)
        let presenter: NewsPresenter = NewsPresenter()
        let interactor: NewsInteractor = NewsInteractor(presenter: presenter, newsService: newsService)
        let view: NewsViewController = NewsViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
