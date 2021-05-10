//
//  AppDelegate.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    private var moviesList = [Movie]()
    
    private var timer: Timer? // used for search delay
    
    private var textToSearch: String = "" {
        didSet {
            guard oldValue != textToSearch else { return }
            clearData()

            if textToSearch == "" {
                fetchTrending()
            } else {
                searchMovies(forText: textToSearch)
            }
        }
    }
    
    private var currentPage: Int {
        moviesList.count / Consts.itemsPerFetch
    }
    
    // MARK: - Subviews
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        search.searchBar.placeholder = Consts.searchBarPlaceholder
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MovieCell.self, forCellReuseIdentifier: NSStringFromClass(MovieCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchTrending()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.deselectRows()
    }
    
    // MARK: - Network
    
    private func fetchMoreMovies() {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            searchMovies(forText: searchText)
        } else {
            fetchTrending()
        }
    }
    
    private func fetchTrending() {
        Servise().getTranding(forPage: currentPage + 1) { (result) in
            self.setResult(result)
        }
    }
    
    private func searchMovies(forText: String) {
        Servise().searchMovies(forPage: currentPage + 1, searchText: forText) { (result) in
            self.setResult(result)
        }
    }
    
    // MARK: - Methods
    
    private func setUI() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        activityIndicator.frame = .init(x: 0, y: 0, width: 44, height: 44)
        activityIndicator.startAnimating()
        tableView.tableFooterView = activityIndicator
        
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func setResult(_ result: (Result<Trending, Error>)) {
        switch result {
        case .failure:
            DispatchQueue.main.async {
                self.presentErrorAlert()
            }
        case .success(let model):
            DispatchQueue.main.async {
                self.moviesList.append(contentsOf: model.results)
                let indexPaths = self.getIndexPathsToAdd(numberOfItems: model.results.count)
                self.tableView.insertRows(at: indexPaths, with: .none)
            }
        }
    }
    
    private func getIndexPathsToAdd(numberOfItems: Int) -> [IndexPath] {
        let startIndex = moviesList.count - numberOfItems
        let endIndex = moviesList.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func clearData() {
        moviesList.removeAll()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MovieCell.self), for: indexPath) as! MovieCell
        let item = moviesList[indexPath.row]
        cell.movie = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesList[indexPath.row]
        let vc = MovieDetailViewController(movieId: movie.id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            fetchMoreMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UISearchBarDelegate

extension MoviesListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // timer is needed to get some delay in search while typing (not to send 5 request after typing 5 letters word)
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: Consts.searchDelay, repeats: false, block: { (_) in
            self.textToSearch = searchText
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        textToSearch = ""
    }

}
