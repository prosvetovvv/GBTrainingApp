//
//  NewsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 18.11.2020.
//

import Foundation

struct NewsService {
    
    private let baseUrl = "https://api.vk.com/method"
    let token           = Session.shared.token
    
    
    func getNews(completed: @escaping (Result<NewsResponseStruct, ErrorMessage>) -> Void) {
        let urlRequest = baseUrl + "/newsfeed.get?filter=post&access_token=\(token)&v=5.124"
        print(urlRequest)
        
        guard let url = URL(string: urlRequest) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                    let newsResponseStruct = newsResponse.response
                    completed(.success(newsResponseStruct))
                } catch {
                    print(error)
                    completed(.failure(.invalidData))
                    return
                }
            }
        }
        
        task.resume()
    }
}
