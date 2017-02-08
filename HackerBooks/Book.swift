//
//  Book.swift
//  HackerBooks
//
//  Created by Fran Delgado on 4/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation
import UIKit

class Book {

    //MARK: - Aliases
    typealias Autores   = [Author]
    typealias Tags      = [Tag]
    
    //MARK: - Stored properties
    let title       : String
    let authors     : Autores
    var tags        : Tags
    let coverUrl    : URL
    let cover       : UIImage
    let pdfUrl      : URL
    let pdf         : Data
    var isFavourite : Bool
 
    //MARK: - Initialization
    init(
        title: String,
        authors: Autores,
        tags: Tags,
        coverUrl: URL,
        cover: UIImage,
        pdfUrl: URL,
        pdf: Data,
        isFavourite: Bool) {
        
        self.title = title
        self.authors = authors
        self.tags = tags
        self.coverUrl = coverUrl
        self.cover = cover
        self.pdfUrl = pdfUrl
        self.pdf = pdf
        self.isFavourite = isFavourite
        
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
        return "\(title)"
    }
    
    func proxyForComparison() -> String {
        return proxyForEquality()
    }
    
    func stringTags() -> String {
        var stringTags = ""
        
        for tag in tags {
            if tag.name != "Favourites" {
                stringTags += tag.name + " - "
            }
            
        }
        
        return String(stringTags.characters.dropLast(3))
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
            return "<\(type(of:self)): \(title) - \(tags)>"
        }
    }
}

extension Book : Hashable {
    
    public var hashValue : Int {
        get {
            return proxyForEquality().hashValue
        }
    }
}
