//
//  SavedController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class SavedController: UIViewController {
    
    private let savedArticleView = SavedArticleView()

    public var datapersistance: DataPersistence<Article>!
    
    /*
     TODO
     - create a SavedArticleView
     - add a collection view to the SavedArticleView
     - collection view is vertical with 2 cells per row
     - add SavedArticleViewController
     - create an array of savedArticle = [Article]
     - reload collection view in disSet of savedArticle array
     */
    
    override func loadView() {
        view = savedArticleView
    }
    
    var savedArticles = [Article]() {
        didSet {
            savedArticleView.collectionView.reloadData()
            if savedArticles.isEmpty {
                // set up emptyview on the collection view back ground view 
                savedArticleView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "Nothing saved! Go Read")
            } else {
                // remove empty view
                savedArticleView.collectionView.backgroundView = nil
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedArticles()

        savedArticleView.collectionView.register(SavedArticleCell.self, forCellWithReuseIdentifier: "savedArticleCell")
        savedArticleView.collectionView.dataSource = self
        savedArticleView.collectionView.delegate = self
    }
    
    private func loadSavedArticles() {
            do {
                savedArticles = try datapersistance.loadItems()
            } catch {
                print("could not load saved articles: \(error)")
            }
    }
}

extension SavedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticleCell", for: indexPath) as? SavedArticleCell else {
            fatalError("could not down cast to SavedArticleCell")
        }
        let article = savedArticles[indexPath.row]
        cell.backgroundColor = .white
        cell.configureCell(for: article)
        cell.delegate = self
        return cell
    }
}

extension SavedController: SavedArticleCellDelegate {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article) {
       // present action sheet
        
       
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            alertAction in self.deleteArticle(article)
            
            //self.savedArticles.remove(at: index)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true)
        
    }
    
    private func deleteArticle(_ article: Article) {
        
        guard let index = savedArticles.firstIndex(of: article) else {
                   fatalError("no index")
               }
        // deletes from doc directory
        
        do {
            try datapersistance.deleteItem(at: index)
        } catch {
            print("error deleting article \(error)")
        }
    }
    
}

extension SavedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBtwnItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight: CGFloat = maxSize.height * 0.3
        let totalSpacing: CGFloat = (2 * spacingBtwnItems) + (numberOfItems - 1) * spacingBtwnItems
        let itemWidth = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension SavedController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        loadSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadSavedArticles()
    }
}


