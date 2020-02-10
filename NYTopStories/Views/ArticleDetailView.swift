//
//  ArticleDetailView.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    
    public lazy var newsimageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
       }()
    
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
        label.numberOfLines = 0
        label.text = "Title"
        return label
    }()
    
    public lazy var abrtact: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Abstract"
        return label
    }()
    
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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
        setUptitleConstraints()
        setupImageViewConstraints()
        setupAbstractLabel()
    }
    
    private func setUptitleConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    
    private func setupImageViewConstraints() {
        addSubview(newsimageView)
        newsimageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsimageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            newsimageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            newsimageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            newsimageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45)
        ])
    }
    
    private func setupAbstractLabel() {
        addSubview(abrtact)
        abrtact.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abrtact.topAnchor.constraint(equalTo: newsimageView.bottomAnchor, constant: 10),
            abrtact.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abrtact.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    
    
}
