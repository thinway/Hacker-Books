//
//  JSONProcessing.swift
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

//MARK: - Aliases
typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String: JSONObject]
typealias JSONArray         = [JSONDictionary]

//MARK: - Decodification

func decodeLibrary(jsonLibrary json: JSONArray) throws -> [Book] {

    let decodedBooks = try json.flatMap({try decode(book: $0)})

    return decodedBooks
}

func decode(book json: JSONDictionary) throws -> Book {
    
    let title = json["title"] as! String
    
    var authors = [Author]()
    if let authorsField = json["authors"] as? String {
        authors = Author.toArray(str: authorsField)
    }
    
    var tags = Tags()
    if let tagsField = json["tags"] as? String {
        tags = Tag.toArray(str: tagsField)
    }
    
    // Cover default image
    //let defaultCoverName = "default_cover.png"
    //guard let cover = UIImage(named: defaultCoverName) else {
    //    throw BookError.unreachableResource
    //}
    
    // Cover URL
    guard let coverUrlString = json["image_url"] as? String,
        let coverUrl = URL(string: coverUrlString) else {
            throw BookError.wrongURLFormatJSONResource
    }
    
    var image = Data()

    if let coverUrlString = json["image_url"] as? String {
        image = try getFileFrom(stringUrl: coverUrlString)
    }else{
        let coverDefaultUrl = "default_cover.png"
        if let coverDefault = Bundle.main.url(forResource: coverDefaultUrl){
            image = try! Data(contentsOf: coverDefault)
        }
    }
    
    // Default PDF
    let defaultPdf = "default_pdf.pdf";
    guard let defaultPdfUrl = Bundle.main.url(forResource: defaultPdf),
        let pdf = try? Data(contentsOf: defaultPdfUrl) else {
            throw BookError.unreachableResource
    }

    guard let pdfUrlString = json["pdf_url"] as? String,
        let pdfUrl = URL(string: pdfUrlString) else {
            throw BookError.wrongURLFormatJSONResource
    }
    
    return Book(
        title: title,
        authors: authors,
        tags: tags,
        coverUrl: coverUrl,
        cover: UIImage(data: image)!,
        pdfUrl: pdfUrl,
        pdf: pdf,
        isFavourite: false)
}

func decode(book json: JSONDictionary?) throws -> Book {
    
    guard let json = json else {
        throw BookError.nilJSONObject
    }
    
    return try decode(book: json)
}

func decodeTags(booksArray books: [Book]) -> [Tag] {
    
    var tags = [Tag]()
    let favourite = Tag(name: "Favourite")
    
    for book in books {
        // Check the favourite books
        if book.isFavourite && !tags.contains(favourite) {
            tags.append(favourite)
        }
        for tag in book.tags {
            if !tags.contains(tag){
                tags.append(tag)
            }
            
        }
    }
    
    return tags.sorted()
}

func existTag(tagName: String) {
    
}

//MARK: - Loading

func loadFromLocalFile(fileName name: String, bundle: Bundle = Bundle.main) throws -> JSONArray {
    
    if let url = bundle.url(forResource: name),
        let data = try? Data(contentsOf: url),
        let maybeArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray
    {
        return array;
    } else {
        throw BookError.jsonParsingError
    }
}

func jsonLoadFromData(dataInput data: Data) throws -> JSONArray{
    
    if let maybeArray = try? JSONSerialization.jsonObject(with: data,
                                                          options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {
        return array
    }else{
        throw BookError.jsonWrongFile
    }
    
}
