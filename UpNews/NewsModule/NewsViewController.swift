//
//  ViewController.swift
//  UpNews
//
//  Created by Peter on 29.01.2025.
//

import UIKit

final class NewsViewController: UIViewController {
    // MARK: - Variables
    private var interactor: (NewsBusinessLogic & ArticleDataStore)?
    
    // MARK: - Lifecycle
    init(interactor: (NewsBusinessLogic & ArticleDataStore)?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    // MARK: - Methods
    func displayNews() { }
}
