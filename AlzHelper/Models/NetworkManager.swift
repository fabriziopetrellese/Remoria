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
    @Published var pixabayImageUrls = [String]()
    
    private init() {}

    //private class propeeties
    private enum Endpoint {
        
        case query(categoryName: String, label: String)
        case keywordQuery(keyword: String)
        
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
            
            var components = self.getURLComponents()
                    
            switch self {
            case .query(let categoryName, let label):
                components.queryItems = [
                    URLQueryItem(name: "key", value: "27990515-86dc2681fe9aa112039668d4f"),
                    URLQueryItem(name: "q", value: "\(categoryName)+\(label)"),
                    URLQueryItem(name: "image_type", value: "photo"),
                    URLQueryItem(name: "orientation", value: "vertical"),
                    URLQueryItem(name: "category", value: categoryName),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "per_page", value: "20")
                ]
              
            case .keywordQuery(let keyword):
                components.queryItems = [
                    URLQueryItem(name: "key", value: "27990515-86dc2681fe9aa112039668d4f"),
                    URLQueryItem(name: "q", value: keyword),
                    URLQueryItem(name: "image_type", value: "photo"),
                    URLQueryItem(name: "orientation", value: "vertical"),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "per_page", value: "20")
                ]
            }
            
            return components.url
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
    
    //category and label queries
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
            return pixabayHits
            
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
                print("Error! Pixabay server responded with error: \(httpResponse.description)")
            }
            
            let items = try JSONDecoder().decode(Pixabay.self, from: data)
            if let item = items.hits.first {
                self.pixabayImageUrl = item.webformatURL
                return pixabayImageUrl
            }
            
            return nil
            
        } catch {
            print("Error! Failed to fetch imageUrl of category + label from Pixabay")
            return nil
        }
    }
    
    //keyword queries
    func getItemImageUrl(using keyword: String) async -> String? {
        
        guard let url = Endpoint.keywordQuery(keyword: keyword).url else {
            fatalError("Error! Failed to construct Pixabay url")
        }
        print("Pixabay API request url: \(url)")
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Error! Pixabay server responded with error: \(httpResponse.description)")
            }
            
            let items = try JSONDecoder().decode(Pixabay.self, from: data)
            if let item = items.hits.first {
                self.pixabayImageUrl = item.webformatURL
                return pixabayImageUrl
            }
            
            return nil
            
        } catch {
            print("Error! Failed to fetch imageUrl of category + label from Pixabay")
            return nil
        }
    }
    
    func getItemImageUrls(using keyword: String) async -> [String] {
        
        guard let url = Endpoint.keywordQuery(keyword: keyword).url else {
            fatalError("Error! Failed to construct Pixabay url")
        }
        print("Pixabay API request url: \(url)")
        
        var imageUrls = [String]()
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Error! Pixabay server responded with error: \(httpResponse.description)")
            }
            
            let items = try JSONDecoder().decode(Pixabay.self, from: data)
            if !items.hits.isEmpty {
                items.hits.forEach { hit in
                    imageUrls.append(hit.webformatURL)
                }
            }
        } catch {
            print("Error! Failed to fetch imageUrls for keyword from Pixabay")
        }
        
        self.pixabayImageUrls = imageUrls
        return pixabayImageUrls
    }
}
