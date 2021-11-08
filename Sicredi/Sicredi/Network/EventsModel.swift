//
//  EventsModel.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Foundation

struct Event: Codable {
    let people: [String]?
    let date: Int
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case people, date, description, image, longitude, latitude, price, title, id
    }
}
