//
//  Endpoint.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/09/19.
//

import Foundation


enum EndPoint {
    
    
    case fromID(param: Int)
    case singleBeer
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/beers"
    }
    
    var endPoint: URL? {
        switch self {
        case .fromID(let param):
            if let url = URL(string: baseURL + "?\(param)") {
                print(url)
                return url
            }
        case .singleBeer:
            if let url = URL(string: baseURL + "/1") {
                print(url)
                return url
            }
        case .randomBeer:
            if let url = URL(string: baseURL + "/random") {
                print(url)
                return url
            }
        }
        return nil
    }
    
    
}
