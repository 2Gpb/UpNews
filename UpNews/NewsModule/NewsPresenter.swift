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
    func presentNews(articles: [Article]) {
        view?.displayNews()
    }
}
