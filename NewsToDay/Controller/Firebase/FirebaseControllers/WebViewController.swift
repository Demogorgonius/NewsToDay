//
//  WebViewController.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    //MARK: - Properties
    private let webView = WKWebView()
    private let urlString: String
    
    //MARK: - Lifecycle
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        webViewLoad()
    }
    
    //MARK: - Methods
    private func webViewLoad() {
        guard let url = URL(string: urlString) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.webView.load(URLRequest(url: url))
    }
    
    @objc private func didTapDone() {
        dismiss(animated: true)
    }
    
    //MARK: - UI Setup
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        /// ADDING SUBVIEWS
        view?.addSubview(webView)
        
        /// TAMIC
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
