//
//  NewsEndpoint.swift
//  UpNews
//
//  Created by Peter on 31.01.2025.
//

enum NewsEndpoint: Endpoint {
    case section(
        rubricId: Int,
        pageSize: Int,
        pageIndex: Int
    )
    
    var compositePath: String {
        switch self {
        case .section:
            return "/api/Section"
        }
    }
    
    var headers: [String : String] { [:] }
    
    var parameters: [String : String]? {
        var result: [String : String] = [:]
        switch self {
        case .section(let rubricId, let pageSize, let pageIndex):
            result = [
                "rubricId": "\(rubricId)",
                "pageSize": "\(pageSize)",
                "pageIndex": "\(pageIndex)"
            ]
        }
        
        return result
    }
}
