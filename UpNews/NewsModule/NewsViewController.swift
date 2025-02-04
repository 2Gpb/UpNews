//
//  ViewController.swift
//  UpNews
//
//  Created by Peter on 29.01.2025.
//

import UIKit
import SafariServices

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
            static let backgroundColor: UIColor = .primaryGray
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let verticalIndicator: Bool = true
            static let horizontalOffset: CGFloat = 0
            static let heightForRowAt: CGFloat = 400
            static let swipeTitle: String = "Share"
            static let swipeImg: UIImage? = UIImage(systemName: "square.and.arrow.up")
            static let estimatedRowHeight: CGFloat = 400
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
        newsTableView.estimatedRowHeight = Constants.TableView.estimatedRowHeight
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.subviews.forEach { subview in
            if let scrollIndicator = subview as? UIImageView {
                // Проверяем, что это именно индикатор прокрутки
                if scrollIndicator.frame.size.width <= 1 {  // Обычно вертикальный индикатор имеет маленькую ширину
                    scrollIndicator.tintColor = .red  // Устанавливаем нужный цвет
                }
            }
        }
        
        view.addSubview(newsTableView)
        newsTableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        newsTableView.pinBottom(to: view.bottomAnchor)
        newsTableView.pinHorizontal(to: view, Constants.TableView.horizontalOffset)
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        interactor.loadWebView(indexPath.row)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .normal,
            title: Constants.TableView.swipeTitle
        ) { [weak self] _, _, completion in
            self?.interactor.loadActivityController(indexPath.row)
            completion(true)
        }
        
        action.backgroundColor = .primaryBlue
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let menu = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in
            let shareAction = UIAction(
                title: Constants.TableView.swipeTitle,
                image: Constants.TableView.swipeImg
            ) { [weak self] _ in
                self?.interactor.loadActivityController(indexPath.row)
            }
            
            return UIMenu(children: [shareAction])
        }
        
        return menu
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 2) {
            interactor.loadMoreNews()
        }
    }
}

extension NewsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        newsTableView.reloadData()
    }
}
