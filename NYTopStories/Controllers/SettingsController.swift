//
//  SettingsController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

struct UserKey {
    static let sectionName = "News Section"
}

class SettingsController: UIViewController {

    private let settingsView = SettingsView()
    
    private let sections = ["Arts", "Automobiles", "Books", "Business", "Fashion", "Food", "Health", "Insider", "Magazine", "Movies", "NYRegion", "Obituaries", "Opinion", "Politics", "RealeEstate", "Science", "Sports", "SundayReview", "Technology", "Theater", "T-Magazine", "Travel", "Upshot", "US", "World"].sorted()
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        
        // set up picker view
        
        settingsView.pickerView.dataSource = self
        settingsView.pickerView.delegate = self
    }
}


extension SettingsController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
}


extension SettingsController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // store current section in user defaults
        let sectionName = sections[row]
        UserDefaults.standard.set(sectionName, forKey: UserKey.sectionName)
        
    }
}
