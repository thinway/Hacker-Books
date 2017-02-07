//
//  Tag.swift
//  HackerBooks
//
//  Created by Fran Delgado on 5/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation

class Tag {
    
    let name : String
    
    init(name: String) {
        self.name = name
    }
    
    //MARK: - Proxies
    func proxieForEquality() -> String{
        return "\(name)"
    }
    
    func proxieForComparison() -> String{
        return proxieForEquality()
    }
}

//MARK: - Extensions
extension Tag : Equatable{
    public static func ==(lhs: Tag, rhs: Tag) -> Bool{
        return lhs.proxieForEquality() == rhs.proxieForEquality()
    }
}

extension Tag : Comparable{
    
    public static func <(lhs: Tag, rhs: Tag) -> Bool{
        return (lhs.proxieForComparison() < rhs.proxieForComparison())
    }
    
}

extension Tag : CustomStringConvertible{
    public var description: String {
        get{
            return "[\(type(of:self))]: \(name)"
        }
    }
}

extension Tag : Hashable {
    
    public var hashValue: Int {
        get {
            return proxieForEquality().hashValue
        }
    }
}

//MARK: - Static Functions
extension Tag {
    
    static func toArray(str: String) -> [Tag] {
        // Array of Authors
        let stringsArray = str.components(separatedBy: ", ")
        var tagsArray = [Tag]()
        
        for each in stringsArray {
            let tag = Tag(name: each)
            tagsArray.append(tag)
        }
        
        return tagsArray
    }
}
