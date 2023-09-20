//
//  Router.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    // MARK: - 엔드포인트에대한 케이스 나열
    case singleBeer(param: Int)
    case allBeers(param: String, value: String)
    case randomBeer
    
    // MARK: - BaseURL 선언 -> URL(string:) 파라미터 가진아이로 -> 언래핑+에러처리
    private var baseURL: URL {
        if let url = URL(string: "https://api.punkapi.com/v2/beers") {
            return url
        } else {
            fatalError("Invalid URL")
        }
    }
    
    // MARK: - BaseURL과 결합할 Path 선언 (타입은 String으로)
    var path: String {
        switch self {
        case .singleBeer(let param):
            return "/\(param)"
        case .allBeers(let param, let value):
            return "?\(param)=\(value)"
        case .randomBeer:
            return "/random"
        }
    }
    
    // MARK: - Header가 필요하다면 let header:HTTPHeaders { return 딕셔너리형태 } 로 선언
    
    // MARK: - Method 선언
    private var method: HTTPMethod {
        return .get
    }
    
    // MARK: - 필수 메서드 -> 이 함수는 URL Request 를 반환값으로 뱉음 -> Router 의 최종목적지
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path) // BaseURL 에 path를 갖다붙임
        var request = URLRequest(url: url)
        print(url)
        // request.headers = header // header 가 있는 형식이라면.
        request.method = method // method 여기다 박음
        return request
    }
    
    
}
