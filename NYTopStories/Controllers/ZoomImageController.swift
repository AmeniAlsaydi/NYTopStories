//
//  ZoomImageController.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/14/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ZoomImageController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    private var image: UIImage // we need an initializer class has no member-wise intializer like structs
    
    // coder revolves around archiving and unarchiving View controllers
    
    
    init?(coder: NSCoder, image: UIImage) { // if coming from story board we need a coder that will archive the storyboard and NSCoder is the class that does that // init? -> failable initializer
        
        self.image = image
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { // because we customized an intializer we have to implement required init because it conforms to NSCode - rules to inheritance
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image // this wont work if you have it in the intializ

        scrollView.delegate = self
        scrollView.maximumZoomScale = 5.0
    }
    
    
    
}

extension ZoomImageController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { // tell it what view you want to be scrolled
        return imageView
    }
}
