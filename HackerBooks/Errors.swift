//
//  Errors.swift
//  HackerBooks
//
//  Created by Fran Delgado on 4/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation

enum BookError : Error {
    case resourcePointedByURLNotReachable
    case unreachableResource
    case wrongURLFormatJSONResource
    case nilJSONObject
    case jsonParsingError
    case jsonWrongFile
}
