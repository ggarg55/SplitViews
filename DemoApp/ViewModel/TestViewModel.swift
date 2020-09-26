//
//  TestViewModel.swift
//  DemoApp
//
//  Created by Guest User on 26/09/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation

class TestViewModel {
    var testDataObservable = YBObservable<TestList>([])
    var testData: TestList = []
    init() {
        getTestData()
    }
    
    func getTestData() {
        let jsonParser = YBJsonParser<TestList>(path: kTestJsonPath)
        jsonParser.getData { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch (result) {
            case .success(let testObj):
                self.testData = testObj
                self.testDataObservable.value = testObj
                debugPrint(testObj)
            case .failure(let err):
                debugPrint(err.localizedDescription)
            }
            
        }
    }
}
