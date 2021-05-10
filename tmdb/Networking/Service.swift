//
//  Servise.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import Foundation

struct Servise {
    
    enum TimeWindow: String {
        case day
        case week
    }
    
    enum MediaType: String {
        case all
        case movie
        case tv
        case persone
    }
    
    private let endPoint = Consts.apiBaseUrl
    private let apiKey = Consts.apiKey
    
    private func getTrendingStringUrl(timeWindow: TimeWindow = .day, mediaType: MediaType = .movie, page: Int) -> String {
        var stringUrl = endPoint
        stringUrl += "trending/"
        stringUrl += mediaType.rawValue + "/"
        stringUrl += timeWindow.rawValue
        stringUrl += "?api_key=" + apiKey
        stringUrl += "&page=" + "\(page)"
        return stringUrl
    }
    
    private func getMovieStringUrl(movieId: Int) -> String {
        var stringUrl = endPoint
        stringUrl += "movie/"
        stringUrl += "\(movieId)"
        stringUrl += "?api_key=" + apiKey
        stringUrl += "&append_to_response=credits"
        return stringUrl
    }
    
    func getSearchStringUrl(searchText: String, page: Int) -> String {
        var stringUrl = endPoint
        stringUrl += "search/movie"
        stringUrl += "?api_key=" + apiKey
        stringUrl += "&query=" + searchText
        stringUrl += "&page=" + "\(page)"
        return stringUrl
    }
    
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> ()) {
        let urlString = getMovieStringUrl(movieId: movieId)
        
        fetchData(urlString: urlString, completion: completion)
    }
    
    func getTranding(forPage: Int, completion: @escaping (Result<Trending, Error>) -> ()) {
        let urlString = getTrendingStringUrl(page: forPage)
        
        fetchData(urlString: urlString, completion: completion)
    }
    
    func searchMovies(forPage: Int, searchText: String, completion: @escaping (Result<Trending, Error>) -> ()) {
        let urlString = getSearchStringUrl(searchText: searchText, page: forPage)
        
        fetchData(urlString: urlString, completion: completion)
    }
    
    private func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
    
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(objects))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
