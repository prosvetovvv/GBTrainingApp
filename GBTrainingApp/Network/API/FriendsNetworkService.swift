//
//  FriendsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 18.11.2020.
//

import UIKit

struct FriendsNetworkService {
    
    private let baseUrl = "https://api.vk.com/method"
    let token           = Session.shared.token
    let cache           = NSCache<NSString, UIImage>()
    
    func getFriends(completed: @escaping (Result<[Friend], ErrorMessage>) -> Void) {
        let urlRequest = baseUrl + "/friends.get?fields=photo_200,city,bdate&access_token=\(token)&v=5.124"
        
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
                    let friendsResponse = try decoder.decode(FriendsResponse.self, from: data)
                    let friends = friendsResponse.response.items
                    completed(.success(friends))
                } catch {
                    print(error)
                    completed(.failure(.invalidData))
                    return
                }
            }
        }
        task.resume()
    }
    
    func getPhotos(for friendId: String, completed: @escaping (Result<PhotosResponseStruct, ErrorMessage>) -> Void) {
        let urlRequest = baseUrl + "/photos.getAll?owner_id=\(friendId)&access_token=\(token)&v=5.124"
        
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
                    let photosResponse = try decoder.decode(PhotosResponse.self, from: data)
                    let photosResponseStruct = photosResponse.response
                    completed(.success(photosResponseStruct))
                } catch {
                    print(error)
                    completed(.failure(.invalidData))
                    return
                }
            }
        }
        task.resume()
    }
    
    private func makeUrlComponentsForSearch(with query: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.124")
        ]
        return urlComponents
    }
}
