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
    var bookmarksManager = BookMarksManager()
    private var testPosts: [Results]?
    
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
        testPosts = bookmarksManager.getNewsFromUserDefaults()
        print(testPosts)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        customView.delegate = self
        testPosts = bookmarksManager.getNewsFromUserDefaults()
        view.backgroundColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = NSLocalizedString("TabBar_Bookmarks", comment: "")
        layoutTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testPosts = bookmarksManager.getNewsFromUserDefaults()
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
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
        return testPosts?.count ?? 0
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
        guard let testPosts = testPosts else { return UITableViewCell() }
         let post = testPosts[indexPath.row]
         let topic = post.category?.first ?? ""
         cell.configureCell(image: post.image_url ?? "", topic: topic, news: post.description ?? "")
//         print(cell)
         
        
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
        guard let testPosts = testPosts else { return }
        navigationController?.pushViewController(NewsViewConroller(with: testPosts[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаляем содержимое ячейки
            guard var testPosts = testPosts else { return }
            
            bookmarksManager.deleteNewsFromDefaults(news: testPosts[indexPath.row])
            
            testPosts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Удаляем ячейку из таблицы
            
           print(testPosts)
            let testPostsNew = bookmarksManager.getNewsFromUserDefaults()
            self.testPosts = testPostsNew
            self.tableView.reloadData()
            
        }
    }
}


extension BookmarksViewController: BookmarksViewDelegate {
    
}
