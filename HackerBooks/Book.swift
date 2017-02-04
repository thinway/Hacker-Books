//
//  Book.swift
//  HackerBooks
//
//  Created by Fran Delgado on 4/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation

class Book {
    
    //MARK: - Stored properties
    let title   : String
    let authors : [String]
    let tags    : [String]
    let imageUrl: URL
    let pdfUrl  : URL
 
    //MARK: - Initialization
    init(title: String, authors: [String], tags: [String], imageUrl: URL, pdfUrl: URL) {
        self.title = title
        self.authors = authors.sorted()
        self.tags = tags.sorted()
        self.imageUrl = imageUrl
        self.pdfUrl = pdfUrl
    }
    
    //MARK: - Proxies
    func proxyForEquality() -> String {
        var authorList: String = ""
        var tagList: String = ""
        
        for author in authors {
            authorList += "\(author)"
        }
        
        for tag in tags {
            tagList += "\(tag)"
        }
        return "\(title)\(authorList)\(tagList)\(imageUrl)\(pdfUrl)"
    }
    
    func proxyForComparison() -> String {
        return proxyForEquality()
    }
}

//MARK: - Protocols
extension Book : Equatable {
    public static func ==(lhs: Book, rhs: Book) -> Bool {
        return (lhs.proxyForComparison() == rhs.proxyForComparison())
    }
}

extension Book : Comparable {
    public static func <(lhs: Book, rhs: Book) -> Bool {
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}

extension Book : CustomStringConvertible {
    
    public var description : String {
        get {
            return "<\(type(of:self)): \(title)>"
        }
    }
}
