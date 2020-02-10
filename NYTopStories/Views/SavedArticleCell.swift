//
//  SavedArticleCell.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/10/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

protocol SavedArticleCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article)
}

class SavedArticleCell: UICollectionViewCell {
    
    weak var delegate: SavedArticleCellDelegate?
    
    // more button
    // article title
    // news image
    
    private var currentArticle: Article!
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Article title"
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
        setupMorebuttonConstraints()
        setupArticleTitleConstraints()
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    private func setupMorebuttonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setupArticleTitleConstraints() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureCell(for savedArticle: Article) {
        currentArticle = savedArticle
        articleTitle.text = savedArticle.title
    }
    
}
