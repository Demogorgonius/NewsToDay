//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class BookmarksViewController : CustomViewController<BookmarksView> {
    
    private var viewModels = [TestForBookmarks]()
    private let testPosts = testPost
    
    private lazy var tableView: UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(BookmarksTableViewCell.self,
                       forCellReuseIdentifier: BookmarksTableViewCell.identifier)
       return table
    }()
    
    override func loadView() {
        view = BookmarksView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        view.backgroundColor = .red
//        layoutTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
//    private func layoutTableView() {
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
    }
    

//MARK: - TableView

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testPosts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarksTableViewCell.identifier, for: indexPath)
                as? BookmarksTableViewCell else {
            fatalError()
        }
    
        cell.updateNews(model: testPosts[indexPath.row])
        cell.textLabel?.text = "Some text"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


extension BookmarksViewController: BookmarksViewDelegate {
    
}
