//
//  WebViewAssembly.swift
//  UpNews
//
//  Created by Peter on 02.02.2025.
//

import UIKit

final class WebViewAssembly {
    // MARK: - Build
    static func build(with url: URL?) -> UIViewController {
        let presenter = WebPresenter()
        let interactor = WebInteractor(presenter: presenter, url: url)
        let view = WebViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
