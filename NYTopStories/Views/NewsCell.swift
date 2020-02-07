//
//  NewsCell.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import ImageKit

class NewsCell: UICollectionViewCell {
    
    // image view of the article
    // title of article
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsimageView.clipsToBounds = true
        newsimageView.layer.cornerRadius = 13
        
    }
    
    public lazy var newsimageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        return image
    }() // a function call - calls when its created
    
    
    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article Titile"
        return label
    }()
    
    private lazy var abstactHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract Headline"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupNewssImageCellConstraints()
        setupTitleConstraits()
        setupAbstractConstraints()
    }
    
    private func setupNewssImageCellConstraints() {
        addSubview(newsimageView)
        newsimageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            newsimageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsimageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsimageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            newsimageView.widthAnchor.constraint(equalTo: newsimageView.heightAnchor)
        ])
    }
    
    private func setupTitleConstraits() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: newsimageView.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: newsimageView.trailingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            // instransic value, knows its height
        ])
    }
    
    private func setupAbstractConstraints() {
        addSubview(abstactHeadline)
        abstactHeadline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstactHeadline.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10),
            abstactHeadline.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstactHeadline.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor)
        ])
        
        
    }
    
    public func configureCell(_ article: Article) {
        
        articleTitle.text = article.title
        abstactHeadline.text = article.abstract
        guard let url = article.getArticleImageURL(for: .thumbLarge) else {
            
            return 
        }
        
        newsimageView.getImage(with: url) { (results) in
            switch results {
            case .failure(let appError):
                print("error geting image: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.newsimageView.image = image
                }
            }
        }
    
    }
    
}
