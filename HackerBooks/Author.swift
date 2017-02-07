//
//  Author.swift
//  HackerBooks
//
//  Created by Fran Delgado on 5/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation

class Author {
    
    //MARK: - Stored Properties
    let name : String
    
    //MARK: - Initialization
    init(name: String) {
        self.name = name
    }
    
    //MARK: - Proxies
    func proxyForEquality() -> String{
        return "\(name)"
    }
    
    func proxyForComparison() -> String{
        return proxyForEquality()
    }
}

//MARK: - Extensions
extension Author : Equatable{
    public static func ==(lhs: Author, rhs: Author) -> Bool{
        return lhs.proxyForEquality() == rhs.proxyForEquality()
    }
}

extension Author : Comparable{
    
    public static func <(lhs: Author, rhs: Author) -> Bool{
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
    
}

extension Author : CustomStringConvertible{
    public var description: String {
        get{
            return "[\(type(of:self))]: \(name)"
        }
    }
}

extension Author : Hashable {
    
    public var hashValue: Int {
        get {
            return proxyForEquality().hashValue
        }
    }
}

//MARK: - Static Functions
extension Author {
    
    static func toArray(str: String) -> [Author] {
        // Array of Authors
        let stringsArray = str.components(separatedBy: ", ")
        var authorsArray = [Author]()
        
        for author in stringsArray {
            let author = Author(name: author)
            authorsArray.append(author)
        }
        
        return authorsArray
    }
}
