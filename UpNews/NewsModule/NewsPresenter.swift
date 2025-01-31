//
//  NewsPresenter.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {
    weak var view: NewsViewController?
    
    func presentStart() {
        view?.displayStart()
    }
}
