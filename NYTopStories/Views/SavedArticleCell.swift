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
        label.isUserInteractionEnabled = true
        return label
    }()
    private var isShowingImage = false
    
    private lazy var longPressedGesture: UILongPressGestureRecognizer = {
      let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    private lazy var newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "photo")
        image.clipsToBounds = true
        image.alpha = 0
        return image
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
        addGestureRecognizer(longPressedGesture)
        setupimageConstraints()
    }
    
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began || gesture.state == .changed {
            // animate the view. change from text to image
            return
        }
        
        isShowingImage.toggle()
        guard let currentArticle = currentArticle else { return }

        newsImageView.getImage(with: currentArticle.getArticleImageURL(for: .normal) ?? "normal") { [weak self] (result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self?.newsImageView.image = image
                    self?.animate()
                }
            }
        }
    }
    
    private func animate() {
        let duration: Double = 1.0
        
        if isShowingImage {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.newsImageView.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.newsImageView.alpha = 0.0
            }, completion: nil)
        }
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    private func setupimageConstraints() {
        addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
