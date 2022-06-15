//
//  NetworkManager.swift
//  AlzHelper
//
//  Created by Simon Italia on 15/06/22.
//

import Foundation

class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var pixabayHits = [PixabayHit]()
    @Published var pixabayImageUrl = ""
    
    private init() {}

    //private class propeeties
    private enum Endpoint {
        
        case query(categoryName: String, label: String)
        
        //url components
        enum URLComponent {
            static let scheme = "https"
            static let host = "pixabay.com"
        }
        
        //api endpoint query items
        enum QueryItem {
            static let query = "q"
        }
        
        var url: URL? {
                    
            switch self {
            case .query(let categoryName, let label):
                
                var components = self.getURLComponents()
                components.queryItems = [
                    URLQueryItem(name: "key", value: "27990515-86dc2681fe9aa112039668d4f"),
                    URLQueryItem(name: "q", value: "\(categoryName)+\(label)"),
                    URLQueryItem(name: "image_type", value: "photo"),
                    URLQueryItem(name: "orientation", value: "vertical"),
                    URLQueryItem(name: "category", value: categoryName),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "per_page", value: "20"),
                ]
                
                return components.url
            }
        }
        
        //construct base URL from url components
        private func getURLComponents() -> URLComponents {
            var components = URLComponents()
            components.scheme = URLComponent.scheme
            components.host = URLComponent.host
            components.path = "/api/"
            return components
        }
    }
    
    func getPixabayHits(using query: (categoryName: String, label: String)) async -> [PixabayHit] {
        
        guard let url = Endpoint.query(categoryName: query.categoryName, label: query.label).url else {
            fatalError("Error! Failed to construct Pixabay url")
        }
        print("Pixabay API request url: \(url)")
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                fatalError("Error! Pixabay server responded with an error")
            }
            
            let items = try JSONDecoder().decode(Pixabay.self, from: data)
            self.pixabayHits = items.hits
            return items.hits
            
        } catch {
            fatalError("failed to fetch Pixabay hits")
        }
    }
    
    func getItemImageUrl(using query: (categoryName: String, label: String)) async -> String? {
        
        guard let url = Endpoint.query(categoryName: query.categoryName, label: query.label).url else {
            fatalError("Error! Failed to construct Pixabay url")
        }
        print("Pixabay API request url: \(url)")
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Error! Pixabay server responded with error: \(httpResponse.statusCode)")
            }
            
            let items = try JSONDecoder().decode(Pixabay.self, from: data)
            if let item = items.hits.first {
                self.pixabayImageUrl = item.userImageURL
                return pixabayImageUrl
            }
            
            return nil
            
        } catch {
            return nil
        }
    }
}

struct Pixabay: Codable {
    let total: Int
    let totalHits: Int
    let hits: [PixabayHit]
}

struct PixabayHit: Codable {
    
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth: Int
    let previewHeight: Int
    let webformatURL: String
    let webformatWidth: Int
    let webformatHeight: Int
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let collections: Int
    let likes: Int
    let comments: Int
    let user_id: Int
    let user: String
    let userImageURL: String
}
