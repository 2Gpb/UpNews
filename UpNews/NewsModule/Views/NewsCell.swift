//
//  NewsCell.swift
//  UpNews
//
//  Created by Peter on 01.02.2025.
//

import UIKit

final class NewsCell: UITableViewCell {
    private let label: UILabel = UILabel()
    static let reuseId = "NewsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = .lightGray
        label.text = "test"
        
        addSubview(label)
        label.pinCenter(to: self)
    }
}
