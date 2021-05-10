//
//  CreditsCollectionView.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

class CreditsCollectionView: UICollectionView {
    
    var credits = [CreditType]() {
        didSet {
            self.reloadData()
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellHeight: CGFloat = Consts.Layout.profileImageSize.width + 4 + 16 + 4 + 16 + 4 + 12 + 4 // TODO
        layout.itemSize = .init(width: Consts.Layout.profileImageSize.width, height: cellHeight)
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: cellHeight).isActive = true
        self.register(CreditCell.self, forCellWithReuseIdentifier: NSStringFromClass(CreditCell.self))
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CreditsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CreditCell.self), for: indexPath) as! CreditCell
        cell.credit = credits[indexPath.row]
        return cell
    }
 
}
