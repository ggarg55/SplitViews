//
//  YBJsonParser.swift
//  DemoApp
//
//  Created by Guest User on 26/09/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation

struct YBJsonParser<T: Codable> {
    
    var jsonFilePath: String?
    
    init(path: String) {
        jsonFilePath = path
    }
    
    func getData(completion:  @escaping (Result<T, JsonParsingError>) -> Void) {
        let fileURL = Bundle.main.url(forResource: jsonFilePath, withExtension: kJsonExtString)
        guard let url = fileURL else {
            completion(.failure(JsonParsingError.badURL))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            decodeJsonObject(jsonObject: data, completion: completion)
        } catch {
            debugPrint(error.localizedDescription)
            completion(.failure(JsonParsingError.unknownError(error)))
        }
    }
    
    func decodeJsonObject(jsonObject: Data, completion:  @escaping (Result<T, JsonParsingError>) -> Void) {
        let decoder = JSONDecoder()
        do {
            let concreteObject = try decoder.decode(T.self, from: jsonObject)
            completion(.success(concreteObject))
        } catch {
            completion(.failure(JsonParsingError.unknownError(error)))
        }
    }
 }
