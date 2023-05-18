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

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let sections = MockData.shared.pageData
    private let newsManager = NewsManager()
    var newsData: [Results]?
    private var selectedCategory = ["Мир" : "world",
                                    "World" : "world",
                                    "Развлечения" : "entertainment",
                                    "Entertainment" : "entertainment",
                                    "Природа" : "environment",
                                    "Environment" : "environment",
                                    "Бизнес" : "business",
                                    "Business" : "business",
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
            newsManager.performRequest(category: selectedCategory[selected] ?? "top") { result in
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
            let selectedCategory = MockData.shared.topics.items[indexPath.item].categories
            getNewsFromTopic(category: selectedCategory)
            if let cell = homeView.collectionView.cellForItem(at: indexPath) as? LatestNewsCollectionViewCell {
                if let newDone = newsData {
                    if newDone[indexPath.row].image_url != nil,
                       newDone[indexPath.row].category != nil,
                       newDone[indexPath.row].description != nil {
                        cell.configureCell(image: URL(string: newDone[indexPath.row].image_url!), topic: newDone[indexPath.row].category?[0].uppercased() ?? "", news: newDone[indexPath.row].description ?? "")
                    } else {
                        cell.latestNewsImage.image = UIImage(named: ["city_1", "city_2", "city_3", "city_4", "city_5", "city_6"].randomElement()!)
                        cell.topicNewsLabel.text = "UI/UX DESIGN"
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
                if new[indexPath.row].image_url != nil,
                   new[indexPath.row].category != nil,
                   new[indexPath.row].creator != nil,
                   new[indexPath.row].title != nil,
                   new[indexPath.row].content != nil {
                    newsVC.textDiscription.text = new[indexPath.row].content
                    newsVC.titleLabel.text = new[indexPath.row].title
                    newsVC.autorName.text = new[indexPath.row].creator?[0]
                    newsVC.category.text = new[indexPath.row].category?[0]
                    newsVC.pictureNews.kf.setImage(with: URL(string: new[indexPath.row].image_url ?? ""))
                } else {
                    newsVC.textDiscription.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
                    newsVC.titleLabel.text = cell?.newsLabel.text
                    newsVC.autorName.text = "John Doe"
                    newsVC.category.text = cell?.topicNewsLabel.text
                    newsVC.pictureNews.image = cell?.latestNewsImage.image
                }
            }
            navigationController?.pushViewController(newsVC, animated: true)
            navigationItem.largeTitleDisplayMode = .never
        case .recommended(_):
            print("3")
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
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .textField(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldCollectionViewCell", for: indexPath) as? TextFieldCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case .topics(let topic):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(topicName: topic[indexPath.row].categories)
            return cell
        case .news(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as? LatestNewsCollectionViewCell else { return UICollectionViewCell() }
            if let newsDataNew = newsData {
                if newsDataNew[indexPath.row].image_url != nil,
                   newsDataNew[indexPath.row].category != nil,
                   newsDataNew[indexPath.row].description != nil {
                    cell.configureCell(image: URL(string: newsDataNew[indexPath.row].image_url!), topic: newsDataNew[indexPath.row].category?[0].uppercased() ?? "", news: newsDataNew[indexPath.row].description ?? "")
                } else {
                    cell.latestNewsImage.image = UIImage(named: ["city_1", "city_2", "city_3", "city_4", "city_5", "city_6"].randomElement()!)
                    cell.topicNewsLabel.text = "COLORS"
                    cell.newsLabel.text = "Creating Color Palette from world around you"
                }
            } else {
                cell.latestNewsImage.image = UIImage(named: "city_1")
                cell.newsLabel.text = "ТЕМА"
                cell.topicNewsLabel.text = "НОВОСТЬ"
            }
            return cell
        case .recommended(let recommendedNews):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedNewsCollectionViewCell", for: indexPath) as? RecomendedNewsCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(image: recommendedNews[indexPath.row].image, newTopic: recommendedNews[indexPath.row].newsTopic, news: recommendedNews[indexPath.row].news)
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
