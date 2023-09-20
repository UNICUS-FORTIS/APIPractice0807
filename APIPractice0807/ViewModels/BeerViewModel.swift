//
//  BeerViewModel.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/09/20.
//

import Foundation


final class BeerViewModel {
    
    let apiService = APIService.shared
    
    var beerDisplay = Observable("")
    var beerTitle = Observable("")
    var beerDescription = Observable("")
    
    
    func fetchRequest(endPoint: Router, completion: @escaping(URL) -> Void) {
        apiService.fetchRequest(type: [BeerReco].self, api: endPoint) { result in
            switch result {
            case .success(let data) :
                
                self.beerTitle.value = data[0].name
                self.beerDescription.value = data[0].description
                guard let url = URL(string: data[0].imageURL) else { return }
                completion(url)
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    
    
    
}
