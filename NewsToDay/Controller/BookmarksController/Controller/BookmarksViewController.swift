//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class BookmarksViewController : CustomViewController<BookmarksView>  {
    
    private var viewModels = [TestForBookmarks]()
    var bookmarksData: Results?
    private var testPosts = testPost
    
    private lazy var tableView: UITableView = {
       let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.register(BookmarksTableViewCell.self,
                       forCellReuseIdentifier: BookmarksTableViewCell.identifier)
       return table
    }()
    
    override func loadView() {
        view = BookmarksView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        customView.delegate = self
        view.backgroundColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = NSLocalizedString("TabBar_Bookmarks", comment: "")
        layoutTableView()
    }
    
   
    private func layoutTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    }
    

//MARK: - TableView

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testPosts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarksTableViewCell.identifier, for: indexPath)
                as? BookmarksTableViewCell else {
            fatalError()
        }
        
        cell.updateNewsBookmarks(image: testPosts[indexPath.row].image, title: testPosts[indexPath.row].title, description: testPosts[indexPath.row].description)
//        cell.configureCell(image: URL(string: bookmarksData?[indexPath.row].image_url! ?? ""), topic: bookmarksData?[indexPath.row].category?[0].uppercased() ?? "", news: bookmarksData?[indexPath.row].description ?? "", data: bookmarksData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let headerLabel = UILabel()
        headerLabel.text = "Saved articles to the library"
        headerLabel.textColor = UIColor(named: Colors.greyPrimary)
        headerLabel.font = UIFont(name: Fonts.interRegular, size: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаляем содержимое ячейки
            testPosts.remove(at: indexPath.row)
            // Удаляем ячейку из таблицы
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


extension BookmarksViewController: BookmarksViewDelegate {
    
}
