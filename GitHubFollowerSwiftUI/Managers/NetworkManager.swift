//
//  NetworkManager.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/4/24.
//

import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString,UIImage>()
    let decoder = JSONDecoder()

    private init(){
        decoder.keyDecodingStrategy = . convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    enum GHEndPoints {
        case followers(usernme: String, page: Int)
        case userInfo(username: String)
        
        var urlString: String {
            switch self{
            case .followers(let username, let page):
                return NetworkManager.shared.baseUrl + "\(username)/followers?per_page=100&page=\(page)"
            case .userInfo(let username):
                return NetworkManager.shared.baseUrl + "\(username)"
            }
        }
    }
    
    func getDataForView<T:Decodable>(forEndPoint endPoint : GHEndPoints, responseType : T.Type) async throws -> T{
        let endPointURL = endPoint.urlString
        guard let url = URL(string: endPointURL) else { throw AppError.invalidUsername }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.invalidResponse }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }
    
    func getFollowers(for userName:String, page: Int) async throws -> [Follower] {
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else { throw AppError.invalidUsername }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.invalidResponse }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }

    func getUserInfo(for userName:String) async throws -> User {
        let endPoint = baseUrl + "\(userName)"
        guard let url = URL(string: endPoint) else { throw AppError.invalidUsername }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.invalidResponse }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }

    func getThumbImage(from urlString: String) async -> UIImage?{
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){ return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data : data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
}
