//
//  Untitled.swift
//  UpNews
//
//  Created by Peter on 02.02.2025.
//

import Foundation

protocol WebBusinessLogic {
    func loadStart()
    func loadFinish()
}

protocol WebPresentationLogic {
    func presentWebView(request: URLRequest)
    func closeWebView()
}

protocol WebRoutingLogic {
    func closeWebView()
}
