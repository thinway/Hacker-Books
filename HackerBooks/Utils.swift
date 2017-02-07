//
//  Utils.swift
//  HackerBooks
//
//  Created by Fran Delgado on 6/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation
import UIKit

func downloadJsonFile(fileUrlString fStrUrl: String) throws -> Data {
    
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
