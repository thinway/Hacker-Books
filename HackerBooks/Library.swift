//
//  Library.swift
//  HackerBooks
//
//  Created by Fran Delgado on 4/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation

typealias Books = [Book]
typealias Tags = [Tag]
typealias BooksMultiDictionary = MultiDictionary<Tag, Book>

class Library {
    
    //MARK: - Store Properties
    var books : Books
    var tags  : Tags
    var md    : MultiDictionary<Tag, Book>
    
    init(books: Books, tags: Tags){
        self.books = books
        self.tags = tags
        self.md = BooksMultiDictionary()
            
        self.loadMultiDictionary()
    }
    
    //MARK: - Accessors
    
    var booksCount: Int {
        get {
            let count: Int = self.books.count
            return count
        }
    }
    
    var tagsCount: Int {
        get {
            return md.keys.count
        }
    }
    
    func bookCount(forTag tagName: Tag) -> Int {
        guard let booksInTag = md[tagName]?.count else {
            return 0
        }
        
        return booksInTag
    }
    
    func bookCount(forTag tag: Tag) -> [Book]? {
        
        guard let bookCountForTag = md[tag] else {
            return [Book]()
        }
        
        return Array(bookCountForTag).sorted()
    }
    
    func book(forTag tag: Tag, at: Int) -> Book? {
        let booksArray = Array(md[tag]!).sorted()
        
        return booksArray[at]
    }
    
    func loadMultiDictionary()  {
        self.addEmptyTags()
        let favourite = Tag(name: "Favourite")
        
        for book in books {
            // Check favourite books
            
            if book.isFavourite {
                md.insert(value: book, forKey: favourite)
            }
            
            for tag in book.tags {
                    md.insert(value: book, forKey: tag)
            }
            
            
        }
        
        
    }
    
    func addEmptyTags() {
        for tag in tags {
            md[tag] = Set<Book>()
        }
    }
    
    func tagName(tag: Tag) -> String{
        return tag.name
    }
    
}
