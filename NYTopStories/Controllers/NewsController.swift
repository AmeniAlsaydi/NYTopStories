//
//  NewsController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class NewsController: UIViewController {
    
    private var newsView = NewsView()
    
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsView.collectionView.reloadData()
            }
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
        fetchStories()
    }
    
    private func fetchStories() {
        NYTopStoriesApiClient.fetchTopStories(for: "Techonology") { [weak self] (result) in
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
        
        navigationController?.pushViewController(articleDVC, animated: true)
    }
    
}
