//
//  BeerResults.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/08/08.
//

import Foundation

struct BeerReco: Decodable {
    let id: Int
    let name, description: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case imageURL = "image_url"
    }
}
