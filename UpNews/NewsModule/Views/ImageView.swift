//
//  ImageView.swift
//  UpNews
//
//  Created by Peter on 03.02.2025.
//

import UIKit

final class ImageView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let value: String = "init(coder:) has not been implemented"
        }
        
        enum Image {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let clipsToBounds: Bool = true
            static let backgroundColor: UIColor = .clear
        }
    }
    
    // MARK: - UI Compontents
    private let shimmerView: ShimmerView = ShimmerView()
    private let image: UIImageView = UIImageView()
    
    private var currentLoadingURL: URL?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.value)
    }
    
    // MARK: - Methods
    func loadImage(_ imageUrl: URL) {
        guard currentLoadingURL != imageUrl else { return }
        
        currentLoadingURL = imageUrl
        if imageUrl.absoluteString.contains("http://") {
            return
        }
        
        if let img = ImageCache.shared.getImage(forKey: imageUrl.absoluteString) {
            image.image = img
            shimmerView.isHidden = true
            shimmerView.stopShimmering()
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
            guard let data = data, error == nil, let img = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                guard self?.currentLoadingURL == imageUrl else { return }
                ImageCache.shared.setImage(image: img, forkey: imageUrl.absoluteString)
                self?.image.image = img
                self?.shimmerView.isHidden = true
                self?.shimmerView.stopShimmering()
            }
        }.resume()
    }
    
    func reuse() {
        currentLoadingURL = nil
        image.image = nil
        shimmerView.isHidden = false
        shimmerView.startShimmering()
    }
    
    // MARK: - SetUp
    private func setUp() {
        image.contentMode = Constants.Image.contentMode
        image.clipsToBounds = Constants.Image.clipsToBounds
        image.backgroundColor = Constants.Image.backgroundColor
        shimmerView.startShimmering()
        
        addSubview(shimmerView)
        addSubview(image)
        shimmerView.pin(to: self)
        image.pin(to: self)
    }
}
