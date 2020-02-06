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

    override func loadView() {
        view = newsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // works with night mode
        
        newsView.collectionView.delegate = self
        newsView.collectionView.dataSource = self
        // UICollectionViewCell.self the .self means not an instance but the cell itself
        newsView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "articleCell")

    }

}

extension NewsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath)
        
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
    
}
