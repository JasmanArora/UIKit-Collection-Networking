//
//  NetworkManager.swift
//  CollectionView
//
//  Created by Jasman Arora on 5/8/23.
//

import UIKit


final class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://randomuser.me/api/"
    private let userURL = baseURL + "?results=21"
    
    private init() {}
    /*
    func getAppetizers(completed: @escaping(Result<[Appetizer], APError>) -> Void) {
        
        guard let url = URL(string: appetizerURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error  {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    */
    
    func getUsers() async throws  -> [User] {
        
        guard let url = URL(string: userURL) else {
            throw UserError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
       
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(UserResponse.self, from: data)
            print(decodedResponse)
            print(decodedResponse.results)
            return decodedResponse.results
        } catch {
            throw UserError.invalidData
        }
        
    }
    /*
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
           
            
            guard let data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
            
          
            
        }
            
        task.resume()
    }
    
    */
    
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
        
    }
    
}

