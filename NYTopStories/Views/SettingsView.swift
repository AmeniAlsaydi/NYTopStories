//
//  SettingsView.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/10/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class SettingsView: UIView {


    public lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
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
        setupPickerView()
    }
    
    private func setupPickerView() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
