//
//  ViewController.swift
//  UpNews
//
//  Created by Peter on 29.01.2025.
//

import UIKit

final class NewsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
    }
    
    // MARK: - Variables
    private var interactor: (NewsBusinessLogic & ArticleDataStore)?
    
    // MARK: - Private fields
    private let newsTableView: UITableView = UITableView()
    
    // MARK: - Lifecycle
    init(interactor: (NewsBusinessLogic & ArticleDataStore)?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadFreshNews()
    }
    
    // MARK: - Methods
    func displayNews(_ articles: [Article.ViewModel]?) {
        print(articles ?? "")
        newsTableView.reloadData()
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        setUpNewsTable()
    }
    
    private func setUpNewsTable() {
        newsTableView.delegate = self
        newsTableView.dataSource = interactor
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
        newsTableView.estimatedRowHeight = 400
        
        view.addSubview(newsTableView)
        newsTableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        newsTableView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor)
        newsTableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        newsTableView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor)
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
