//
//  NewsInteractor.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import UIKit

final class NewsInteractor: NewsBusinessLogic, ArticleDataStore {
    private let presenter: NewsPresentationLogic
    var articles: [String] = []
    
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadStart() {
        presenter.presentStart()
    }
    
    func loadFreshNews() {
        
    }
    
    func loadMoreNews() {
        
    }
}
