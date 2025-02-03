//
//  NewsCell.swift
//  UpNews
//
//  Created by Peter on 01.02.2025.
//

import UIKit

final class NewsCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
        
        enum ReuseId {
            static let value = "NewsCell"
        }
        
        enum Cell {
            static let backgroundColor: UIColor = .clear
            static let selectionStyle: UITableViewCell.SelectionStyle = .none
        }
        
        enum Wrap {
            static let backgroundColor: UIColor = .white
            static let cornerRadius: CGFloat = 12
            static let clipsToBounds: Bool = true
            static let horizontalOffset: CGFloat = 4
            static let verticalOffset: CGFloat = 8
        }
        
        enum Image {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let radius: CGFloat = 0
            static let clipsToBounds: Bool = true
            static let topOffset: CGFloat = 0
            static let horizontalOffset: CGFloat = 0
            static let height: CGFloat = 200
        }
        
        enum Title {
            static let numberOfLines: Int = 0
            static let font: UIFont = .systemFont(ofSize: 18, weight: .semibold)
            static let textColor: UIColor = .black
            static let topOffset: CGFloat = 8
            static let horizontalOffset: CGFloat = 12
        }
        
        enum Description {
            static let numberOfLines: Int = 4
            static let font: UIFont = .systemFont(ofSize: 14, weight: .regular)
            static let textColor: UIColor = .lightGray
            static let topOffset: CGFloat = 8
            static let bottomOffset: CGFloat = 12
            static let horizontalOffset: CGFloat = 12
        }
    }
    
    // MARK: - Private fields
    private let wrapView: UIView = UIView()
    private var imgView: ImageView = ImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    // MARK: - ReuseId
    static let reuseId = Constants.ReuseId.value
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.message)
    }
    
    // MARK: - Methods
    func configure(title: String, description: String, url: URL?) {
        titleLabel.text = title
        descriptionLabel.text = description
        imgView.loadImage(url)
    }
    
    // MARK: - SetUp
    private func setUp() {
        self.backgroundColor = Constants.Cell.backgroundColor
        self.selectionStyle = Constants.Cell.selectionStyle
        
        setUpWrap()
        setUpImage()
        setUpTitle()
        setUpDescription()
    }
    
    private func setUpWrap() {
        wrapView.backgroundColor = Constants.Wrap.backgroundColor
        wrapView.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrapView.clipsToBounds = Constants.Wrap.clipsToBounds
         
        addSubview(wrapView)
        wrapView.pinHorizontal(to: self, Constants.Wrap.horizontalOffset)
        wrapView.pinVertical(to: self, Constants.Wrap.verticalOffset)
    }
    
    private func setUpImage() {
        wrapView.addSubview(imgView)
        imgView.pinTop(to: wrapView, Constants.Image.topOffset)
        imgView.pinHorizontal(to: wrapView, Constants.Image.horizontalOffset)
        imgView.setHeight(Constants.Image.height)
    }
    
    private func setUpTitle() {
        titleLabel.numberOfLines = Constants.Title.numberOfLines
        titleLabel.font = Constants.Title.font
        titleLabel.textColor = Constants.Title.textColor
        
        wrapView.addSubview(titleLabel)
        titleLabel.pinTop(to: imgView.bottomAnchor, Constants.Title.topOffset)
        titleLabel.pinHorizontal(to: imgView, Constants.Title.horizontalOffset)
    }
    
    private func setUpDescription() {
        descriptionLabel.numberOfLines = Constants.Description.numberOfLines
        descriptionLabel.font = Constants.Description.font
        descriptionLabel.textColor = Constants.Description.textColor
        
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.Description.topOffset)
        descriptionLabel.pinHorizontal(to: imgView, Constants.Description.horizontalOffset)
        descriptionLabel.pinBottom(to: wrapView, Constants.Description.bottomOffset)
    }
}
