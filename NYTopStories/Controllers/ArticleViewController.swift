//
//  ArticleViewController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class ArticleViewController: UIViewController {
    
    private let detailView = ArticleDetailView()
    public var datapersistance: DataPersistence<Article>!
    
    public var article: Article?
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = .systemGroupedBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }
   
    private func updateUI() {
        guard let article = article, let url = article.getArticleImageURL(for: .superJumbo) else {
            fatalError("check didSelect - no article was passed")
        }
        
        
        // TODO: refactor and set up in articleview 
        // e.g detailView.configureView(for article: article) 
        detailView.abrtact.text = article.abstract
        detailView.titleLabel.text = article.title
        
        detailView.newsimageView.getImage(with: url) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.newsimageView.image = image
                }
            }
        }
    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        sender.image = UIImage(systemName: "bookmark.fill")
        
        guard let article = article else { return }
        do {
            try datapersistance.createItem(article)
            
        } catch {
            print("error saving article \(error)")
        }
    }
    

}
