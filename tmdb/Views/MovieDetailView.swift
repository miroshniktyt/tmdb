//
//  MovieDetailView.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

class MovieDetailView: UIView {
    
    private let inset: CGFloat = 16
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.ancherSize(size: Consts.Layout.posterSize)
        return imageView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let genersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let crewCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Crew:"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let castCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast:"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
        
    private var crewCollectionView = CreditsCollectionView()
    
    private var castCollectionView = CreditsCollectionView()
    
    private var separatorLine: UIView {
        let line = UIView()
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line.backgroundColor = .separator
        return line
    }
    
    init(movieDetails: MovieDetails) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setUI()
        setData(movieDetails: movieDetails)
    }
    
    private func setData(movieDetails: MovieDetails) {
        
        titleLabel.text = movieDetails.titleName
        
        overviewLabel.text = movieDetails.overview
        
        posterImageView.setImage(path: movieDetails.poster, size: .w185)
        
        let geneterStr: [String] = movieDetails.genres.map { return $0.name }
        genersLabel.text = geneterStr.joined(separator: " | ")
        
        dateLabel.text = movieDetails.date.replacingOccurrences(of: "-", with: " ")
        
        crewCollectionView.credits = movieDetails.credits.crew
        
        castCollectionView.credits = movieDetails.credits.cast
    }
    
    private func setUI() {
        crewCollectionView.contentInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        castCollectionView.contentInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        
        let posterOverviewStackView = UIStackView(arrangedSubviews: [posterImageView, overviewLabel])
        posterOverviewStackView.spacing = inset
        posterOverviewStackView.alignment = .top
        posterOverviewStackView.translatesAutoresizingMaskIntoConstraints = false
        posterOverviewStackView.axis = .horizontal
        
        let layoutInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        let verticalStackView = UIStackView(arrangedSubviews: [
            titleLabel.insideContainerView(withInsets: layoutInsets),
            dateLabel.insideContainerView(withInsets: layoutInsets),
            genersLabel.insideContainerView(withInsets: layoutInsets),
            posterOverviewStackView.insideContainerView(withInsets: layoutInsets),
            separatorLine.insideContainerView(withInsets: layoutInsets),
            crewCaptionLabel.insideContainerView(withInsets: layoutInsets),
            crewCollectionView,
            separatorLine.insideContainerView(withInsets: layoutInsets),
            castCaptionLabel.insideContainerView(withInsets: layoutInsets),
            castCollectionView
        ])
        verticalStackView.spacing = 8
        verticalStackView.alignment = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        
        self.addSubview(verticalStackView)
        verticalStackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension UIView {
    func insideContainerView(withInsets insets: UIEdgeInsets) -> UIView {
        let container = UIView()
//        container.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        self.fillSuperview(insets: insets)
        return container
    }
}
