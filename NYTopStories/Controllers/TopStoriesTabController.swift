//
//  TopStoriesTabController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class TopStoriesTabController: UITabBarController {

    // there should only be one instance of the data persistance 
    private var datapersistance = DataPersistence<Article>(filename: "savedArticles.plist")
    
    

    private lazy var newsVC: NewsController = {
       let vc = NewsController()
         vc.datapersistance = datapersistance
        vc.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return vc
    }()

    private lazy var savedVC: SavedController = {
       let vc = SavedController()
        vc.datapersistance = datapersistance
        vc.datapersistance.delegate = vc
        vc.tabBarItem = UITabBarItem(title: "Read Later", image: UIImage(systemName: "folder"), tag: 1)
        return vc
    }()
    
    private lazy var settingsVC: SettingsController = {
       let vc = SettingsController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [UINavigationController(rootViewController: newsVC),
                           UINavigationController(rootViewController: savedVC),
                           UINavigationController(rootViewController: settingsVC)]
        
    }
    


}


