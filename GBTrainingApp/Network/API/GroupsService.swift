//
//  GroupsService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 17.11.2020.
//

import UIKit

struct GroupsService {
    
    private let baseUrl = "https://api.vk.com/method"
    let token           = Session.shared.token
    
    
    func getGroups(completion: @escaping (Result<[Group], ErrorMessage>) -> Void) {
        let urlRequest = baseUrl + "/groups.get?extended=1&access_token=\(token)&v=5.124"
        print(urlRequest)
        guard let url = URL(string: urlRequest) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let decoder = JSONDecoder()
                    let groupResponse = try decoder.decode(GroupsResponse.self, from: data)
                    let groups = groupResponse.response.items
                    print(groups)
                    completion(.success(groups))
                } catch {
                    print(error)
                    completion(.failure(.invalidData))
                    return
                }
            }
        }
        
        task.resume()
    }
}
