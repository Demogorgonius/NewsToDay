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
    private let homeView = HomeView()
    private let sections = MockData.shared.pageData
    private let newsManager = NewsManager()
    private var previousSelectedIndex: IndexPath?
    var recNewsData: [Results]?
    var newsData: [Results]?
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataRecNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func fetchDataRecNews() {
        let categories = catManager.getCategories() as! [String]
        newsManager.performRequest(category: arrayToString(array: categories)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.recNewsData = data
                    self.homeView.collectionView.reloadData()
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
                    print(self.newsData)
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
            if let cell = homeView.collectionView.cellForItem(at: indexPath) as? LatestNewsCollectionViewCell {
                if let newDone = newsData {
                    if newDone[indexPath.row].image_url != nil,
                       newDone[indexPath.row].category != nil,
                       newDone[indexPath.row].description != nil {
                        cell.configureCell(image: URL(string: newDone[indexPath.row].image_url!), topic: newDone[indexPath.row].category?[0].uppercased() ?? "", news: newDone[indexPath.row].description ?? "")
                    } else if newDone[indexPath.row].image_url == nil {
                        cell.latestNewsImage.image = UIImage(named: ["city_1", "city_2", "city_3", "city_4", "city_5", "city_6"].randomElement()!)
                        cell.topicNewsLabel.text = newDone[indexPath.row].category?[0].uppercased()
                        cell.newsLabel.text = newDone[indexPath.row].title
                    } else if newDone[indexPath.row].category == nil {
                        cell.latestNewsImage.kf.setImage(with: URL(string: newDone[indexPath.row].image_url ?? ""))
                        cell.topicNewsLabel.text = "UI/UX DESIGN"
                        cell.newsLabel.text = newDone[indexPath.row].title
                    } else if newDone[indexPath.row].description == nil {
                        cell.latestNewsImage.kf.setImage(with: URL(string: newDone[indexPath.row].image_url ?? ""))
                        cell.topicNewsLabel.text = newDone[indexPath.row].category?[0]
                        cell.newsLabel.text = "A Simple Trick For Creating Color Palettes Quickly"
                    }
                } else {
                    cell.latestNewsImage.image = UIImage(named: "city_1")
                    cell.topicNewsLabel.text = "ТЕМА"
                    cell.newsLabel.text = "НОВОСТЬ"
                }
            }
        case .news(_):
            let newsVC = NewsViewConroller()
            let cell = homeView.collectionView.cellForItem(at: indexPath) as? LatestNewsCollectionViewCell
            if let new = newsData {
                if new[indexPath.row].image_url != nil {
                    newsVC.pictureNews.kf.setImage(with: URL(string: new[indexPath.row].image_url ?? ""))
                } else {
                    newsVC.pictureNews.image = cell?.latestNewsImage.image
                }
                if new[indexPath.row].category != nil {
                    newsVC.category.text = new[indexPath.row].category?[0].uppercased()
                } else {
                    newsVC.category.text = cell?.topicNewsLabel.text
                }
                if new[indexPath.row].creator != nil {
                    newsVC.autorName.text = new[indexPath.row].creator?[0]
                } else {
                    newsVC.autorName.text = "John Doe"
                }
                if new[indexPath.row].title != nil {
                    newsVC.titleLabel.text = new[indexPath.row].title
                } else {
                    newsVC.titleLabel.text = cell?.newsLabel.text
                }
                if new[indexPath.row].link != nil {
                    newsVC.linkNews = new[indexPath.row].link
                } else {
                    newsVC.linkNews = ""
                }
                if new[indexPath.row].content != nil {
                    newsVC.textDiscription.text = new[indexPath.row].content
                } else {
                    newsVC.textDiscription.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
                }
            }
            navigationController?.pushViewController(newsVC, animated: true)
        case .recommended(_):
            let newsVC = NewsViewConroller()
            let cell = homeView.collectionView.cellForItem(at: indexPath) as? RecomendedNewsCollectionViewCell
            if let news = recNewsData {
                if news[indexPath.row].image_url != nil {
                    newsVC.pictureNews.kf.setImage(with: URL(string: news[indexPath.row].image_url ?? ""))
                } else {
                    newsVC.pictureNews.image = cell?.cellImage.image
                }
                if news[indexPath.row].category != nil {
                    newsVC.category.text = news[indexPath.row].category?[0].uppercased()
                } else {
                    newsVC.category.text = cell?.newsTopicLabel.text
                }
                if news[indexPath.row].creator != nil {
                    newsVC.autorName.text = news[indexPath.row].creator?[0]
                } else {
                    newsVC.autorName.text = "John Doe"
                }
                if news[indexPath.row].title != nil {
                    newsVC.titleLabel.text = news[indexPath.row].title
                } else {
                    newsVC.titleLabel.text = cell?.newsLabel.text
                }
                if news[indexPath.row].link != nil {
                    newsVC.linkNews = news[indexPath.row].link
                } else {
                    newsVC.linkNews = ""
                }
                if news[indexPath.row].content != nil {
                    newsVC.textDiscription.text = news[indexPath.row].content
                } else {
                    newsVC.textDiscription.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
                }
            } 
            navigationController?.pushViewController(newsVC, animated: true)
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
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .textField(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldCollectionViewCell", for: indexPath) as? TextFieldCollectionViewCell else { return UICollectionViewCell() }
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
                    cell.configureCell(image: URL(string: newDone[indexPath.row].image_url!), topic: newDone[indexPath.row].category?[0].uppercased() ?? "", news: newDone[indexPath.row].description ?? "")
                } else if newDone[indexPath.row].image_url == nil {
                    cell.latestNewsImage.image = UIImage(named: ["city_1", "city_2", "city_3", "city_4", "city_5", "city_6"].randomElement()!)
                    cell.topicNewsLabel.text = newDone[indexPath.row].category?[0].uppercased()
                    cell.newsLabel.text = newDone[indexPath.row].title
                } else if newDone[indexPath.row].category == nil {
                    cell.latestNewsImage.kf.setImage(with: URL(string: newDone[indexPath.row].image_url ?? ""))
                    cell.topicNewsLabel.text = "UI/UX DESIGN"
                    cell.newsLabel.text = newDone[indexPath.row].title
                } else if newDone[indexPath.row].description == nil {
                    cell.latestNewsImage.kf.setImage(with: URL(string: newDone[indexPath.row].image_url ?? ""))
                    cell.topicNewsLabel.text = newDone[indexPath.row].category?[0]
                    cell.newsLabel.text = "A Simple Trick For Creating Color Palettes Quickly"
                }
            } else {
                cell.latestNewsImage.image = UIImage(named: "city_1")
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
                    cell.cellImage.image = UIImage(named: ["city_1", "city_2", "city_3", "city_4", "city_5", "city_6"].randomElement()!)
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
                cell.cellImage.image = UIImage(named: "city_1")
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
