//
//  Book.swift
//  HackerBooks
//
//  Created by Fran Delgado on 4/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation
import UIKit

/*
 {
 "authors": "Scott Chacon, Ben Straub",
 "image_url": "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg",
 "pdf_url": "https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf",
 "tags": "version control, git",
 "title": "Pro Git"
 }
 */

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
            stringTags += tag.name + " - "
        }
        
        return stringTags
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
