//
//  HomeViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class HomeViewController: UIViewController {

    private let catManager = CategoriesManager()
    var a = TextFieldCollectionViewCell()
    private let homeView = HomeView()
    private let sections = MockData.shared.pageData
    private let newsManager = NewsManager()
    private var previousSelectedIndex: IndexPath?
    var recNewsData: [Results]?
    var newsData: [Results]?
    var newsCatOld: [String]?
    var newsCatNew: [String]?
    private var selectedCategory = ["Мир" : "world",
                                    "World" : "world",
                                    "Развлечения" : "entertainment",
                                    "Entertainment" : "entertainment",
                                    "Природа" : "environment",
                                    "Environment" : "environment",
                                    "Бизнес" : "business",
                                    "Business" : "business",
                                    "Политика" : "politics",
                                    "Politics" : "politics",
                                    "Еда" : "food",
                                    "Food" : "food",
                                    "Здоровье" : "health",
                                    "Health" : "health",
                                    "Наука" : "science",
                                    "Science" : "science",
                                    "Спорт" : "sports",
                                    "Sport" : "sports",
                                    "Технологии" : "technology",
                                    "Technology" : "technology",
                                    "Туризм" : "tourism",
                                    "Tourism" : "tourism"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupViews()
        setDelegates()
        fetchDataNews()
        fetchDataRecNews()
        newsCatOld = catManager.getCategories() as? [String]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cat = newsCatNew {
            if let catOld = newsCatOld {
                if cat != catOld {
                    fetchDataRecNews()
                }
            }
        }
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    private func fetchDataRecNews() {
        let categories = catManager.getCategories() as! [String]
        newsManager.performRequest(category: arrayToString(array: categories)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.recNewsData = data
                    self.homeView.collectionView.reloadSections(IndexSet(integer: 3))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func arrayToString(array: [String]) -> String {
        var finalString = ""
        for element in array {
            finalString += "\(element),"
        }
        return finalString
    }
    
    private func fetchDataNews() {
        newsManager.performRequest(category: "world") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.newsData = data
                    self.homeView.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getNewsFromTopic(category: String) {
        if let index = MockData.shared.topics.items.firstIndex(where: { $0.categories == category }) {
            let selected = MockData.shared.topics.items[index].categories
            newsManager.performRequest(category: selectedCategory[selected] ?? "world") { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let news):
                        self.newsData = news
                        self.homeView.collectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func setupViews() {
        homeView.collectionView.register(TextFieldCollectionViewCell.self, forCellWithReuseIdentifier: "TextFieldCollectionViewCell")
        homeView.collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        homeView.collectionView.register(LatestNewsCollectionViewCell.self, forCellWithReuseIdentifier: "LatestNewsCollectionViewCell")
        homeView.collectionView.register(RecomendedNewsCollectionViewCell.self, forCellWithReuseIdentifier: "RecomendedNewsCollectionViewCell")
        homeView.collectionView.register(HeaderSupplemetaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplemetaryView")
        homeView.collectionView.collectionViewLayout = createLayout()
    }
    
    private func setDelegates() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .textField(_):
                return self.createTextFieldSection()
            case .topics(_):
                return self.createTopicSection()
            case .news(_):
                return self.createNewsSection()
            case .recommended(_):
                return self.createRecommendedNewsSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    private func createTextFieldSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(112)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 32, trailing: 20)
        return section
    }
    
    private func createTopicSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(32)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 24, trailing: 20)
        return section
    }
    
    private func createNewsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(256), heightDimension: .absolute(256)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 48, trailing: 20)
        return section
    }
    
    private func createRecommendedNewsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(96)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.supplementariesFollowContentInsets = false
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.contentInsets = .init(top: 24, leading: 20, bottom: 16, trailing: 20)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}


extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = sections[indexPath.section]
        switch section {
        case .textField(_):
            print("0")
        case .topics(_):
            let previousIndex = previousSelectedIndex
            previousSelectedIndex = indexPath
            homeView.collectionView.reloadItems(at: [previousIndex, indexPath].compactMap { $0 })
            let selectedCategory = MockData.shared.topics.items[indexPath.item].categories
            getNewsFromTopic(category: selectedCategory)
        case .news(_):
            if let new = newsData {
                let newsVC = NewsViewConroller(with: new[indexPath.row])
                navigationController?.pushViewController(newsVC, animated: true)
            }

            
        case .recommended(_):
            
            if let news = recNewsData {
                let newsVC = NewsViewConroller(with: news[indexPath.row])
                navigationController?.pushViewController(newsVC, animated: true)
            }
            
            
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .textField(_):
            return 1
        case .topics(_):
            return 10
        case .news(_):
            return 10
        case .recommended(_):
            if let recNews = recNewsData {
                if recNews.count > 5 {
                    return 5
                }
                if recNews.count < 5 {
                    return recNews.count
                }
            }
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .textField(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldCollectionViewCell", for: indexPath) as? TextFieldCollectionViewCell else { return UICollectionViewCell() }
            cell.searchTextField.delegate = self
            return cell
        case .topics(let topic):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
            let isSelected = (indexPath == previousSelectedIndex)
            cell.categoryLabel.backgroundColor = isSelected ? .purplePrimary : .greyLighter
            cell.categoryLabel.textColor = isSelected ? .white : .greyPrimary
            cell.configureCell(topicName: topic[indexPath.row].categories)
            return cell
        case .news(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as? LatestNewsCollectionViewCell else { return UICollectionViewCell() }
            if let newDone = newsData {
                if newDone[indexPath.row].image_url != nil,
                   newDone[indexPath.row].category != nil,
                   newDone[indexPath.row].description != nil {
                    cell.configureCell(image: URL(string: newDone[indexPath.row].image_url!),
                                       topic: newDone[indexPath.row].category?[0].uppercased() ?? "",
                                       news: newDone[indexPath.row].description ?? "",
                                       newsData: newDone[indexPath.row])
                } else if newDone[indexPath.row].image_url == nil {
                    cell.configureCell(image: nil,
                                       topic: newDone[indexPath.row].category?[0].uppercased() ?? "",
                                       news: newDone[indexPath.row].description ?? "",
                                       newsData: newDone[indexPath.row])
                } else if newDone[indexPath.row].category == nil {
                    cell.configureCell(image: URL(string: newDone[indexPath.row].image_url!),
                                       topic: newDone[indexPath.row].category?[0].uppercased() ?? "",
                                       news: newDone[indexPath.row].description ?? "",
                                       newsData: newDone[indexPath.row])
                } else if newDone[indexPath.row].description == nil {
                    cell.configureCell(image: URL(string: newDone[indexPath.row].image_url!),
                                       topic: newDone[indexPath.row].category?[0].uppercased() ?? "",
                                       news: newDone[indexPath.row].description ?? "",
                                       newsData: newDone[indexPath.row])
                }
            } else {
                cell.latestNewsImage.image = UIImage(named: "city_6")
                cell.newsLabel.text = "ТЕМА"
                cell.topicNewsLabel.text = "НОВОСТЬ"
            }
            return cell
        case .recommended(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedNewsCollectionViewCell", for: indexPath) as? RecomendedNewsCollectionViewCell else { return UICollectionViewCell() }
            if let newsDataNew = recNewsData {
                
                if newsDataNew[indexPath.row].image_url != nil {
                    cell.cellImage.kf.setImage(with: URL(string: newsDataNew[indexPath.row].image_url!))
                } else {
                    cell.cellImage.image = UIImage(named: "city_6")
                }
                if newsDataNew[indexPath.row].category != nil {
                    cell.newsTopicLabel.text = newsDataNew[indexPath.row].category?[0].uppercased() ?? ""
                } else {
                    cell.newsTopicLabel.text = "COLORS"
                }
                if newsDataNew[indexPath.row].description != nil {
                    cell.newsLabel.text = newsDataNew[indexPath.row].title ?? ""
                } else {
                    cell.newsLabel.text = "Creating Color Palette from world around you"
                }
            } else {
                cell.cellImage.image = UIImage(named: "city_6")
                cell.newsTopicLabel.text = "ТЕМА"
                cell.newsLabel.text = "НОВОСТЬ"
            }
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = homeView.collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                  withReuseIdentifier: "HeaderSupplemetaryView", for: indexPath) as! HeaderSupplemetaryView
            header.configureHeader(labelName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension HomeViewController {
    private func addViews() {
        view.addSubview(homeView.collectionView)
        addConstraints()
    }
    
    private func addConstraints() {
        homeView.collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    private func fetchSearchData(text: String) {
        newsManager.performRequest(textFieldText: text) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.newsData = data
                    self.homeView.collectionView.reloadSections(IndexSet(integer: 2))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            a.searchTextField.placeholder = "YEAAAAAHHH"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let search = textField.text {
            fetchSearchData(text: search)
        }
    }
}
