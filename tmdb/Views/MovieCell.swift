//
//  MovieCell.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var movie: Movie? {
        didSet{
            if let movie = movie {
                titleLabel.text = movie.title
                overviewLabel.text = movie.overview
                posterImageView.setImage(path: movie.poster, size: .w154)
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .label
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        UIView.animate(withDuration: 0.25) {
            self.transform = selected ? .init(scaleX: 0.95, y: 0.95) : .identity
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.25) {
            self.transform = highlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
        }
    }
    
    private func setLayout() {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator

        let posterSize = Consts.Layout.posterSize
        self.separatorInset = .init(top: 0, left: posterSize.width + 32, bottom: 0, right: 0)
        posterImageView.ancherSize(size: posterSize)
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        
        let stack = UIStackView(arrangedSubviews: [posterImageView, labelsStack])
        stack.alignment = .center
        stack.spacing = 16
        
        self.contentView.addSubview(stack)
        stack.fillSuperview(insets: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
}

