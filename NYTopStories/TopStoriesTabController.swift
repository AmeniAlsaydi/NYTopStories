//
//  TopStoriesTabController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class TopStoriesTabController: UITabBarController {

    private lazy var newsVC: NewsController = {
       let vc = NewsController()
        vc.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return vc
    }()

    private lazy var savedVC: NewsController = {
       let vc = NewsController()
        vc.tabBarItem = UITabBarItem(title: "Read Later", image: UIImage(systemName: "folder"), tag: 1)
        return vc
    }()
    
    private lazy var settingsVC: NewsController = {
       let vc = NewsController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.949457705, green: 0.6923578978, blue: 0.7100731134, alpha: 1)
        
        viewControllers = [newsVC, savedVC, settingsVC]
        
    }
    


}
