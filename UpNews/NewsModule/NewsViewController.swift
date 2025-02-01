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
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .white
        setUpNewsTable()
    }
    
    private func setUpNewsTable() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
        
        view.addSubview(newsTableView)
        newsTableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        newsTableView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor)
        newsTableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        newsTableView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor)
    }
}

extension NewsViewController: UITableViewDelegate {
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsCell.reuseId,
            for: indexPath
        ) as? NewsCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
