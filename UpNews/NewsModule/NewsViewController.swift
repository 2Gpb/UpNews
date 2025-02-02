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
        
        enum View {
            static let backgroundColor: UIColor = .primaryGray
        }
        
        enum TableView {
            static let backgroundColor: UIColor = .clear
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let verticalIndicator: Bool = false
            static let horizontalOffset: CGFloat = 4
            static let heightForRowAt: CGFloat = 400
        }
    }
    
    // MARK: - Variables
    private var interactor: NewsBusinessLogic & ArticleDataStore
    
    // MARK: - Private fields
    private let newsTableView: UITableView = UITableView()
    
    // MARK: - Lifecycle
    init(interactor: NewsBusinessLogic & ArticleDataStore) {
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
        super.viewDidAppear(animated)
        interactor.loadStart()
    }
    
    // MARK: - Methods
    func displayNews() {
        newsTableView.reloadData()
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = Constants.View.backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: true)
        setUpNewsTable()
    }
    
    private func setUpNewsTable() {
        newsTableView.backgroundColor = Constants.TableView.backgroundColor
        newsTableView.separatorStyle = Constants.TableView.separatorStyle
        newsTableView.showsVerticalScrollIndicator = Constants.TableView.verticalIndicator
        newsTableView.delegate = self
        newsTableView.dataSource = interactor
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
        
        view.addSubview(newsTableView)
        newsTableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        newsTableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        newsTableView.pinHorizontal(to: view, Constants.TableView.horizontalOffset)
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.TableView.heightForRowAt
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.loadWebView(indexPath.row)
    }
}
