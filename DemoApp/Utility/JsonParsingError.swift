//
//  JsonParsingError.swift
//  DemoApp
//
//  Created by Guest User on 26/09/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation

enum JsonParsingError: Error {
    case badURL
    case unknownError(Error)
}
