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
    private var datapersistence: DataPersistence<Article>
    private var article: Article
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    
    
    // initializer
    
    init(_ datapersistence: DataPersistence<Article>, article: Article) {
        self.datapersistence = datapersistence
        self.article = article
        super.init(nibName: nil, bundle: nil) // since this controller is inheriting
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = .systemGroupedBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    
        // set up gesture
        detailView.newsimageView.isUserInteractionEnabled = true // by default image view and label is false
        detailView.newsimageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        
        let image = detailView.newsimageView.image ?? UIImage()
        // we need to get an instance of the zoomImageVC from storyboard
        
        let zoomImageStoryboard = UIStoryboard(name: "ZoomImage", bundle: nil)
        
        let zoomImageVC = zoomImageStoryboard.instantiateViewController(identifier: "ZoomImageController") { coder in
            return ZoomImageController(coder: coder, image: image)
        }
        present(zoomImageVC, animated: true)
    }
   
    private func updateUI() {
        guard let url = article.getArticleImageURL(for: .superJumbo) else {
            fatalError("issue with url for image")
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
       
        do {
            try datapersistence.createItem(article)
            
        } catch {
            print("error saving article \(error)")
        }
    }
    

}
