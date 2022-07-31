//
//  API.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import Foundation

final class Api {
    
    let baseURL = "https://joke.deno.dev"
    
    func decodeData(url: String, completion: @escaping (Result<JokeModel?, Error>)-> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ошибка запроса: \(error)")
            }
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(JokeModel.self, from: data)
                completion(.success(json))
            } catch let error {
                print("Ошибка парсинга: \(error)")
            }
        }.resume()
    }
}
