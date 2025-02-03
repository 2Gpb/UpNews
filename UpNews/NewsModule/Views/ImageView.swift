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
    func loadImage(_ imageUrl: URL?) {
        guard let url = imageUrl else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                if let img = UIImage(data: data) {
                    self?.image.image = img
                    self?.shimmerView.stopShimmering()
                }
            }
        }.resume()
    }
    
    // MARK: - Private methods
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
