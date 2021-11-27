//
//  ApiEngine.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import Foundation

class ApiEngine {
    private let baseUrl = URL(string: "https://www.omdbapi.com/?apikey=c0f30125&")
    private let session = URLSession.shared
    private let defaults = UserDefaults.standard
    static let shared = ApiEngine()
     
    private init() {
      // Singleton
    }
    
    func searchMovies(_ title: String,
                      completionHandler: @escaping ([SearchMovie]?, URLResponse?, Error?) -> Void) {
        
        let path = "s=\(title)&type=\(TypeEnum.movie)"
        guard let url = URL(string:"\(baseUrl!)\(path)") else { return }
        let request = URLRequest(url: url)
        
        let task = session.searchTask(with: request) {
            searchResult, response, error in
            
            if (error != nil) {
                print("Error WS Search Movies: \(String(describing: error))\n\nResponse: \(String(describing: response))")
                completionHandler(nil, response, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let code = httpResponse.statusCode
                print("Search Movies: \(code)")
            }
            
            if let searchResult = searchResult {
                completionHandler(searchResult.search, response, error)
                return
            }

            completionHandler(nil, response, error)
        }
        task.resume()
    }
}
