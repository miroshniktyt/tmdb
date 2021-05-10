//
//  CreditView.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import Foundation
import UIKit

class CreditCell: UICollectionViewCell {
    
    var credit: CreditType? {
        didSet {
            guard let credit = credit else { return }
            
            titleLabel.text = credit.name
            subtitleLabel.text = credit.subtitle
            imageView.setImage(path: credit.image, size: .w154)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Consts.Layout.profileImageSize.width / 2
        imageView.ancherSize(size: Consts.Layout.profileImageSize)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel, UIView()])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
