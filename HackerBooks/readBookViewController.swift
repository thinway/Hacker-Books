//
//  readBookViewController.swift
//  HackerBooks
//
//  Created by Fran Delgado on 7/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import UIKit

class readBookViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var browser: UIWebView!
    
    var model : Book
    
    //MARK: - Initialization
    init(model: Book) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Sync model -> View
    func syncViewWithModel() {
        
        // Create an URLRequest
        let req = URLRequest(url: model.pdfUrl)
        
        // Load it in the browser
        browser.loadRequest(req)
    }
    
    //MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        syncViewWithModel()
        
        edgesForExtendedLayout = .all
        
        browser.delegate = self
        
        // baja
        subscribe()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribe()
    }
}

extension readBookViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        // Show the spinner
        spinner.isHidden = false
        
        // Start Spinner
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // Hide the spinner
        spinner.isHidden = true
        
        // Stop the spinner
        spinner.stopAnimating()
    }
}

//MARK: - Notifications
extension readBookViewController {
    
    func subscribe() {
        // Ref. al NotificationCenter
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: LibraryTableViewController.notificationName, object: nil, queue: OperationQueue.main)
        { (note: Notification) in
            
            // Extraigo el personaje de la notificación
            let userInfo = note.userInfo
            let book = userInfo?[LibraryTableViewController.bookKey]
            
            // cambio modelo
            self.model = book as! Book
            
            // actualizo las vistas
            self.syncViewWithModel()
        }
    }
    
    func unsubscribe() {
        // Ref. al NotificationCenter
        let nc = NotificationCenter.default
        
        nc.removeObserver(self)
    }
}
