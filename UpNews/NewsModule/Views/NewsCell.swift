//
//  NewsCell.swift
//  UpNews
//
//  Created by Peter on 01.02.2025.
//

import UIKit

final class NewsCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let image: UIImageView = UIImageView()
    static let reuseId = "NewsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, description: String, img: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        image.image = img
    }
    
    private func setUp() {
        self.backgroundColor = .lightGray
        self.selectionStyle = .none
        setUpTitle()
        setUpDescription()
        setUpImage()
    }
    
    private func setUpTitle() {
        titleLabel.numberOfLines = 0
        
        addSubview(titleLabel)
        titleLabel.pinTop(to: self, 5)
        titleLabel.pinLeft(to: self, 5)
        titleLabel.pinRight(to: self, 5)
    }
    
    private func setUpDescription() {
        descriptionLabel.numberOfLines = 4
        
        addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 10)
        descriptionLabel.pinLeft(to: self, 5)
        descriptionLabel.pinRight(to: self, 5)
    }
    
    private func setUpImage() {
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.backgroundColor = .cyan
        
        addSubview(image)
        image.pinTop(to: descriptionLabel.bottomAnchor, 5)
        image.pinRight(to: self, 5)
        image.pinLeft(to: self, 5)
        image.pinBottom(to: self, 5)
        image.setHeight(260)
    }
}
