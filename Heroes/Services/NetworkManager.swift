//
//  NetworkManager.swift
//  Heroes
//
//  Created by mac mini on 6/7/22.
//
import Foundation
enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

enum Link: String {
    case url = "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json"
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(heroes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
//    func fetchImage(from url: String?, with completion: @escaping (Result<Data, NetworkError>) -> Void) {
//        guard let url = URL(string: url ?? "") else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//            DispatchQueue.global().async {
//                guard let imageData = try? Data(contentsOf: url) else {
//                    completion(.failure(.noData))
//                    return
//                }
//                DispatchQueue.main.async {
//                    completion(.success(imageData))
//                }
//            }
//    }
}

class ImageManager {
    static let shared = ImageManager()
    
    init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
