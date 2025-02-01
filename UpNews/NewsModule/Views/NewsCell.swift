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
        
        enum Image {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let radius: CGFloat = 12
            static let clipsToBounds: Bool = true
            static let verticalOffset: CGFloat = 8
            static let horizontalOffset: CGFloat = 4
        }
        
        enum Description {
            static let numberOfLines: Int = 4
            static let font: UIFont = .systemFont(ofSize: 15, weight: .semibold)
            static let textColor: UIColor = .white
            static let bottomOffset: CGFloat = 8
            static let horizontalOffset: CGFloat = 8
        }
        
        enum Title {
            static let numberOfLines: Int = 0
            static let font: UIFont = .systemFont(ofSize: 19, weight: .bold)
            static let textColor: UIColor = .primaryBlue
            static let bottomOffset: CGFloat = 8
            static let horizontalOffset: CGFloat = 8
        }
        
        enum GradientLayer {
            static let startPoint: CGPoint = CGPoint(x: 0.5, y: 0)
            static let endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
            static let locations: [NSNumber] = [0, 0.7]
            static let colors: [CGColor] = [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.8).cgColor
            ]
        }
    }
    
    // MARK: - Private fields
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let image: UIImageView = UIImageView()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpGradientLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.layer.sublayers?.removeAll()
    }
    
    // MARK: - Methods
    func configure(title: String, description: String, img: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        image.image = img
    }
    
    // MARK: - SetUp
    private func setUp() {
        self.backgroundColor = Constants.Cell.backgroundColor
        self.selectionStyle = Constants.Cell.selectionStyle
        
        setUpImage()
        setUpDescription()
        setUpTitle()
    }
    
    private func setUpImage() {
        image.contentMode = Constants.Image.contentMode
        image.layer.cornerRadius = Constants.Image.radius
        image.clipsToBounds = Constants.Image.clipsToBounds
        
        addSubview(image)
        image.pinVertical(to: self, Constants.Image.verticalOffset)
        image.pinHorizontal(to: self, Constants.Image.horizontalOffset)
    }
    
    private func setUpDescription() {
        descriptionLabel.numberOfLines = Constants.Description.numberOfLines
        descriptionLabel.font = Constants.Description.font
        descriptionLabel.textColor = Constants.Description.textColor
        
        addSubview(descriptionLabel)
        descriptionLabel.pinBottom(to: image.bottomAnchor, Constants.Description.bottomOffset)
        descriptionLabel.pinHorizontal(to: image, Constants.Description.horizontalOffset)
    }
    
    private func setUpTitle() {
        titleLabel.numberOfLines = Constants.Title.numberOfLines
        titleLabel.font = Constants.Title.font
        titleLabel.textColor = Constants.Title.textColor
        
        addSubview(titleLabel)
        titleLabel.pinBottom(to: descriptionLabel.topAnchor, Constants.Title.bottomOffset)
        titleLabel.pinHorizontal(to: image, Constants.Title.horizontalOffset)
    }
    
    private func setUpGradientLayer() {
        if image.layer.sublayers?.contains(where: { $0 is CAGradientLayer }) == true {
            return
        }
        
        gradientLayer.colors = Constants.GradientLayer.colors
        gradientLayer.startPoint = Constants.GradientLayer.startPoint
        gradientLayer.endPoint = Constants.GradientLayer.endPoint
        gradientLayer.locations = Constants.GradientLayer.locations
        gradientLayer.frame = image.bounds
        image.layer.addSublayer(gradientLayer)
    }
}
