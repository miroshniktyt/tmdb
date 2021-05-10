//
//  MovieDetailViewController.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    private let movieId: Int
    
    var movieDetails: MovieDetails?
    
    // Using tableView with one cell instead of scrollView
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Init
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        self.getData()
    }
    
    // MARK: - Network
    
    private func setUI() {
        view.backgroundColor = .systemBackground
        
        tableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.ancherToSuperviewsCenter()
        
        self.view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func getData() {
        Servise().getMovieDetail(movieId: movieId) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.sync {
                    self.presentErrorAlert()
                }
            case .success(let details):
                DispatchQueue.main.sync {
                    self.movieDetails = details
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        
        if let movieDetails = movieDetails {
            let movieDetailsView = MovieDetailView(movieDetails: movieDetails)
            cell.addSubview(movieDetailsView)
            movieDetailsView.fillSuperview()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
