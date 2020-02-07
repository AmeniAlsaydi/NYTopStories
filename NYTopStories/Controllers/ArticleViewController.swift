//
//  ArticleViewController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    private let detailView = ArticleDetailView()
    
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
        guard let article = article else {
            fatalError("check didSelect - no article was passed")
        }
        
        navigationItem.title = article.title
    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        sender.image = UIImage(systemName: "bookmark.fill")
        print("article saved")
    }
    

}
