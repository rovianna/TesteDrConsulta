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
    func streamerLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var games = [Game]()
    var streamers = [Streamer]()
    
    func getTwitchTopGames(limit: String, completion: @escaping callback) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard let URL = URL(string : "\(GET_TWITCHTOP_URL)\(limit)") else {
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
                    //Função para ORDER_BY
                    self.games = Game.sortGameArrayData(game: self.games, order_by: ORDER_BY)
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
    
    func getTwitchStreamers(game: String, completion: @escaping callback) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard let URL = URL(string: "\(GET_TWITCHSTREAMS_URL)\(game)") else {
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
                    self.streamers = Streamer.parseStreamerJSONData(data: data)
                    self.delegate?.streamerLoaded()
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
