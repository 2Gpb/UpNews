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
        let presenter: NewsPresenter = NewsPresenter()
        let interactor: NewsInteractor = NewsInteractor(presenter: presenter)
        let view: NewsViewController = NewsViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
