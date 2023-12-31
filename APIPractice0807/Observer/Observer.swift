//
//  Observer.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/09/20.
//

import Foundation

final class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(_ completion: @escaping (T) -> Void) {
        completion(value)
        listener = completion
    }
    
}
