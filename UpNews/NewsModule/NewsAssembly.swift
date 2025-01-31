//
//  File.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//
import UIKit

enum NewsAssembly {
    static func build() -> UIViewController {
        let presenter = NewsPresenter()
        let interactor = NewsInteractor(presenter: presenter)
        let view = NewsViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
