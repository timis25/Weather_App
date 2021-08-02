//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Timur Israilov on 02/08/21.
//

import Foundation

struct WeatherModel: Decodable {
    let fact: Fact?
    let info: Info?
}

struct Fact: Decodable {
    let condition: String?
    let temp: Int?
    let feels_like: Int?
    let humidity: Int?
}

struct Info: Decodable {
    let tzinfo: TzInfo?
}

struct TzInfo: Decodable {
    let name: String?
}
