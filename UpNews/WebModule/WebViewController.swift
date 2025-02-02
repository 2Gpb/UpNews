//
//  WebViewController.swift
//  UpNews
//
//  Created by Peter on 02.02.2025.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let value: String = "init(coder:) has not been implemented"
        }
        
        enum View {
            static let backgroundColor: UIColor = .primaryGray
        }
        
        enum BackButton {
            static let image: UIImage = UIImage(named: "backButton") ?? UIImage()
            static let state: UIControl.State = .normal
            static let color: UIColor = .primaryBlue
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 8
            static let left: CGFloat = 8
            static let width: CGFloat = 32
            static let height: CGFloat = 32
        }
        
        enum WebView {
            static let top: CGFloat = 12
        }
    }
    
    // MARK: - Private fields
    private let interactor: WebBusinessLogic
    private let backButton: UIButton = UIButton()
    private let webView = WKWebView()

    // MARK: - Lifecycle
    init(interactor: WebBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        interactor.loadStart()
    }
    
    // MARK: - Methods
    func displayWebView(request: URLRequest) {
        webView.load(request)
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = Constants.View.backgroundColor
        
        setUpBackButtom()
        setUpWebView()
    }
    
    private func setUpBackButtom() {
        backButton.setImage(Constants.BackButton.image, for: Constants.BackButton.state)
        backButton.tintColor = Constants.BackButton.color
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.interactor.loadFinish()
        }), for: Constants.BackButton.event)
        
        view.addSubview(backButton)
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.BackButton.top)
        backButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.BackButton.left)
        backButton.imageView?.setWidth(Constants.BackButton.width)
        backButton.imageView?.setHeight(Constants.BackButton.height)
    }
    
    private func setUpWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: backButton.bottomAnchor, Constants.WebView.top)
        webView.pinBottom(to: view.bottomAnchor)
    }
}
