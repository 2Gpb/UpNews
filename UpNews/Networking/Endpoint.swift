//
//  Endpoint.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

import Foundation

protocol Endpoint {
    var compositePath: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String]? { get }
}

extension Endpoint {
    var parameters: [String: String]? {
        return nil
    }
}
