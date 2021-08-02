//
//  NetworkManager.swift
//  weatherApp
//
//  Created by Timur Israilov on 02/08/21.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    static let apiKey = "1791144a-fb62-47f1-a156-3752fb1abe3a"
    
    enum ApiUrl {
        static let baseUrl = "https://api.weather.yandex.ru/v2/forecast?"
    }
    
    func getCurrentWeather (lat: String, lon: String, completion: @escaping (Result<WeatherModel, AFError>) -> Void) {
        AF.request(ApiUrl.baseUrl, method: .get, parameters:["lat": lat, "lon": lon, "lang": "ru_RU"], headers: .init(["X-Yandex-API-Key" : NetworkManager.apiKey])).responseDecodable(of: WeatherModel.self) {(response) in
            completion(response.result)
        }
    }
}
