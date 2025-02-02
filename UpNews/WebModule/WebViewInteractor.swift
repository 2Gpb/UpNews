//
//  WebViewInteractor.swift
//  UpNews
//
//  Created by Peter on 02.02.2025.
//

import Foundation

final class WebInteractor: WebBusinessLogic {
    // MARK: - Private fields
    private let presenter: WebPresentationLogic & WebRoutingLogic
    private let url: URL?
    
    // MARK: - Lifecycle
    init(presenter: WebPresentationLogic & WebRoutingLogic, url: URL?) {
        self.presenter = presenter
        self.url = url
    }
    
    // MARK: - Methods
    func loadStart() {
        if let url = url {
            presenter.presentWebView(request: URLRequest(url: url))
        }
    }
    
    func loadFinish() {
        presenter.closeWebView()
    }
}
