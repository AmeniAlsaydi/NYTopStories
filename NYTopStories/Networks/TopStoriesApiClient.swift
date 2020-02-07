//
//  TopStoriesApiClient.swift
//  NYTopStories
//
//  Created by Amy Alsaydi on 2/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTopStoriesApiClient {
    static func fetchTopStories(for section: String, completeion: @escaping (Result<[Article], AppError>) -> ()){
        let endpoint = "https://api.nytimes.com/svc/topstories/v2/nyregion.json?api-key=\(Config.apiKey)" // add key
        guard let url = URL(string: endpoint) else {
            completeion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completeion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let stories = try JSONDecoder().decode(TopStories.self, from: data)
                    completeion(.success(stories.results))
                } catch {
                    completeion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
