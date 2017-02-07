//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Fran Delgado on 3/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        do{
            
            let defaults = UserDefaults.standard
            let fileData: Data
        
            if( defaults.bool(forKey: "JsonFileDownloaded") ){
                print("Fichero json descargado")
            
                //defaults.removeObject(forKey: "JsonFileDownloaded")
            
                fileData = try downloadFile(fileUrlString: "https://t.co/K9ziV0z3SJ")
            
            } else {
                print("Fichero json no descargado")
                print("Descargando Fichero ...")
                defaults.set(true, forKey: "JsonFileDownloaded")
            
                fileData = try downloadFile(fileUrlString: "https://t.co/K9ziV0z3SJ")
            }
        
            let booksJson = try jsonLoadFromData(dataInput: fileData)
            
            let books = try decodeLibrary(jsonLibrary: booksJson)
            let tags = decodeTags(booksArray: books)
            let model = Library(books: books, tags: tags)
            
            var indexTag = 0
            for tag in model.tags{
                if let b = model.md[tag] {
                    if(b.count == 0){
                        indexTag += 1
                    }else{
                        break
                    }
                }
            }
            
            //Creamos el LibraryViewController
            let libraryVC = LibraryTableViewController(model: model)
            
            // Navigation Controller
            let libraryNav = UINavigationController(rootViewController: libraryVC)
            libraryNav.navigationBar.topItem?.title = "Hacker Books"
            
            // Create a BookViewController
            let bookVC = BookViewController(model: model.book(forTag: model.tags[0], at: 0)!)
            
            
            // Create a nav for BookViewController
            let bookNav = UINavigationController(rootViewController: bookVC)
            
            // Asignamos delegados
            libraryVC.delegate = bookVC
            
            if(UIDevice.current.userInterfaceIdiom == .phone){
                window?.rootViewController = libraryNav
            }else{
                // Se crea splitViewController
                let splitVC = UISplitViewController()
                splitVC.viewControllers = [libraryNav, bookNav]
                
                // Se lo agregamos a la window
                window?.rootViewController = splitVC
            }
            
            // Mostrar la windows
            window?.makeKeyAndVisible()
            
        }catch{
            fatalError("Error while loading Model from JSON")
        }
        
        
        
        return true
    }

    //MARK: - Utils
    
    func checkFile(fileName: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(fileName)?.path
        let fileManager = FileManager.default
        
        return fileManager.fileExists(atPath: filePath!)
    }
    
    func getFile(jsonUrl: String) throws {
        
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("books_readable.json")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: jsonUrl)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Descarga satisfactorio. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creando el fichero \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Hubo un error durante la descarga. Error: %@", error?.localizedDescription ?? "");
            }
        }
        task.resume()
    }
    
    
}

