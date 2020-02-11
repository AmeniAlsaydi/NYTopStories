//
//  NewsController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class NewsController: UIViewController {
    
    private var newsView = NewsView()
    
    public var datapersistance: DataPersistence<Article>!
    
    
    
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                
                self.newsView.collectionView.reloadData()
                self.navigationItem.title = self.sectionName
            }
        }
    }
    
    private var sectionName = "Technology" {
        didSet {

           //  queryAPI(for: sectionName)
        }
    }

    override func loadView() {
        view = newsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // works with night mode
        
        newsView.collectionView.delegate = self
        newsView.collectionView.dataSource = self
        // UICollectionViewCell.self the .self means not an instance but the cell itself
        newsView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        newsView.searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchStories()
    }
    
    private func fetchStories() {
        // retrieve section name from user defaults
        if let sectionName = UserDefaults.standard.object(forKey: UserKey.sectionName) as? String {
            // self.sectionName = sectionName
            if sectionName != self.sectionName {
                // make a new query
                queryAPI(for: sectionName)
                self.sectionName = sectionName
            } else {
                queryAPI(for: sectionName)
            }
        } else {
            // use the default section name
            queryAPI(for: sectionName)
        }
        
    }
    
    private func queryAPI(for section: String) {
        
        NYTopStoriesApiClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let articles):
                self?.newsArticles = articles
            }
        }
    }
}



extension NewsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? NewsCell else {
            fatalError("could not down cast to newsCell")
        }
        let article = newsArticles[indexPath.row]
        cell.configureCell(article)
        cell.backgroundColor = .white
        
        return cell
    }
}

extension NewsController: UICollectionViewDelegateFlowLayout {
    
    // return item size
    // item hieght 30% of heigh of device
    // item width 100% of width of device
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        
        let itemWidth = maxSize.width
        
        let itemHeight = maxSize.height * 0.20
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        
        let articleDVC = ArticleViewController()
        articleDVC.article = article
        articleDVC.datapersistance = datapersistance
        
        navigationController?.pushViewController(articleDVC, animated: true)
    }
    
    // dimiss keyboard with scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if newsView.searchBar.isFirstResponder {
            newsView.searchBar.resignFirstResponder()
        }
    }
    
}

extension NewsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            fetchStories()
            return
        }
        newsArticles = newsArticles.filter{
            $0.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
    }
}
