//
//  YBObservable.swift
//  DemoApp
//
//  Created by Guest User on 26/09/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation

class YBObservable<T> {
    typealias CompletionHandler = (T) -> Void
    var completion: CompletionHandler?
    
    var value: T {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.completion?(self.value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(completion: CompletionHandler?) {
        self.completion = completion
        completion?(value)
    }
}
