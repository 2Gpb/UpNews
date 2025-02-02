//
//  WebViewPresenter.swift
//  UpNews
//
//  Created by Peter on 02.02.2025.
//

import Foundation
import UIKit

final class WebPresenter: WebPresentationLogic {
    // MARK: - Variables
    weak var view: WebViewController?
    
    // MARK: - Methods
    func presentWebView(request: URLRequest) {
        view?.displayWebView(request: request)
    }
    
}

// MARK: - WebRoutingLogic
extension WebPresenter: WebRoutingLogic {
    func closeWebView() {
        view?.navigationController?.popViewController(animated: true)
    }
}
