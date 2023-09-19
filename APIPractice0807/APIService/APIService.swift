//
//  APIService.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/09/19.
//

import Foundation
import Alamofire

enum NetworkError: Int, Error {
    case invalidEndPoint = 404
    case clientSide = 400
    case serverSide = 500
    case unknown
    
    var errorDescription: String {
        switch self {
        case .invalidEndPoint:
            return "올바른 URL 주소가 아닙니다."
        case .clientSide:
            return "클라이언트 에러가 발생했습니다."
        case .serverSide:
            return "서버 에러가 발생했습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}


class APIService {
    
    static let shared = APIService()
    private init() {}
    
    typealias Network<T> = (Result<T,NetworkError>) -> Void
    
    func fetchRequest<T: Decodable> (type:T.Type,
                                     url: EndPoint,
                                     completion: @escaping Network<T>) {
        
        guard let endUrl = url.endPoint else { return }
        print(endUrl)
        AF.request(endUrl, method: .get).responseDecodable(of: T.self) { response in
            print(response.result)
            switch response.result {
            case.success(let data): completion(.success(data))
                
            case.failure(_):
                let statusCode = response.response? .statusCode ?? 500
                guard let error = NetworkError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
}
