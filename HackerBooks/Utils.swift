//
//  Utils.swift
//  HackerBooks
//
//  Created by Fran Delgado on 6/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation
import UIKit

func downloadFile(fileUrlString fStrUrl: String) throws -> Data {
    
    let rawFile = try? Data(contentsOf: URL(string: fStrUrl)!)
    guard let downloaded = rawFile else {
        throw BookError.unreachableResource
    }
    let fileName = String(fStrUrl.hashValue)
    
    let sourcePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let path = sourcePaths[0]
    let file: URL = URL(fileURLWithPath: fileName, relativeTo: path)
    let fileManager = FileManager.default
    fileManager.createFile(atPath: file.path, contents: downloaded, attributes: nil)
    
    return try loadFromStringUrl(stringUrl: fStrUrl)
    
}

func loadFromStringUrl(stringUrl sUrl: String) throws -> Data{
    
    let fileManager = FileManager.default
    let docsurl = try! fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let fileName = String(sUrl.hashValue)
    let dataUrl = docsurl.appendingPathComponent(fileName)
    
    if let dataFromUrl = try? Data.init(contentsOf: dataUrl) {
        return dataFromUrl
    }else{
        throw BookError.resourcePointedByURLNotReachable
    }
}

//This function recieves a url string. First it confirms that the file already exists and returns a Data value.
//If it doesn't exist, it saves it to the documents folder and returns the Data value
public
func getFileFrom(stringUrl sUrl: String) throws -> Data{
    if(!fileAlreadyExists(stringUrl: sUrl)){
        return try saveToLocalStorage(stringUrl: sUrl)
    }else{
        return try dataFromStringUrl(stringUrl: sUrl)
    }
}

//Returns the internal URL of a file
public
func getInternalUrl(file sUrl: String) throws -> URL{
    let fileName = fileNameFromStringUrl(stringUrl: sUrl)
    if let fileUrl = URL.init(string: fileName) {
        return fileUrl
    }
    return Bundle.main.url(forResource: "default_pdf.pdf")!
}

//Get the name of the file in the document folder. The name of a file is the url hashed
private
func fileNameFromStringUrl(stringUrl sUrl: String) -> String{
    return String(sUrl.hashValue)
}

//This function check if a file exists on the documents folder
private
func fileAlreadyExists(stringUrl sUrl: String) -> Bool{
    
    let fileManager = FileManager.default
    let fileName = fileNameFromStringUrl(stringUrl: sUrl)
    
    //The documents folder url
    let docsurl = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let dataUrl = docsurl.appendingPathComponent(fileName)
    
    // Check if file exists
    if fileManager.fileExists(atPath: dataUrl.path){
        return true
    } else {
        return false
    }
    
}

//This function saves a file on a external url to the documents folder and returns de Data value
private
func saveToLocalStorage(stringUrl sUrl: String) throws -> Data{
    
    let fileData = try? Data(contentsOf: URL(string: sUrl)!)
    guard let downloadedData = fileData else {
        throw BookError.resourcePointedByURLNotReachable
    }
    
    let fileName = fileNameFromStringUrl(stringUrl: sUrl)
    
    let sourcePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let path = sourcePaths[0]
    let file: URL = URL(fileURLWithPath: fileName, relativeTo: path)
    let fileManager = FileManager.default
    fileManager.createFile(atPath: file.path, contents: downloadedData, attributes: nil)
    
    return try dataFromStringUrl(stringUrl: sUrl)
}

//This function returns the Data value of a file that exists on the documents folder.
private
func dataFromStringUrl(stringUrl sUrl: String) throws -> Data{
    
    let fileManager = FileManager.default
    let docsurl = try! fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let fileName = fileNameFromStringUrl(stringUrl: sUrl)
    let dataUrl = docsurl.appendingPathComponent(fileName)
    
    if let dataFromUrl = try? Data.init(contentsOf: dataUrl) {
        return dataFromUrl
    }else{
        throw BookError.resourcePointedByURLNotReachable
    }
}
