//
//  RootNavigationController.swift
//  tmdb
//
//  Created by toha on 10.05.2021.
//

import UIKit
 
class RootNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.navigationBar.barTintColor = .systemBackground
        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.prefersLargeTitles = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
