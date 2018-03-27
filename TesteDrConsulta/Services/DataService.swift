//
//  DataService.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

protocol DataServiceDelegate : class {
    func gameLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var games = [Game]()
    
    func getTwitchTopGames(completion: @escaping callback) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard let URL = URL(string : "\(GET_TWITCHTOP_URL)") else {
            completion(false)
            return
        }
        var request = URLRequest(url: URL)
        request.addValue("\(client_id)", forHTTPHeaderField: "Client-ID")
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                _ = (response as! HTTPURLResponse).statusCode
                if let data = data {
                    self.games = Game.parseGameJSONData(data: data)
                    self.delegate?.gameLoaded()
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
