//
//  LibraryTableViewController.swift
//  HackerBooks
//
//  Created by Fran Delgado on 6/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    //MARK. - Constants
    static let notificationName = Notification.Name(rawValue: "BookDidChange")
    static let bookKey = "BookKey"
        
    //MARK: - Properties
    let model: Library
    weak var delegate: LibraryTableViewControllerDelegate? = nil
    
    //MARK: - Initialization
    init(model: Library) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print(model.tags)
        subscribe()
    }
    
    func reload(){
        model.loadMultiDictionary()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.tags.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // How many books are in this tag?
        return model.bookCount(forTag: getTag(forSection: section))
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return model.tagName(tag: getTag(forSection: section))
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Definir un id para el tipo de celda
        let cellId = "HackerBooksCell"
        
        // Averiguar el tag
        let tag = getTag(forSection: indexPath.section)
        
        // Averiguar el libro
        let book = model.book(forTag: tag, at: indexPath.row)
        
        // Crear la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            // El opcional está vacío y toca crear la celda
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Configurarla
        cell?.imageView?.image = book?.cover
        cell?.textLabel?.text = book?.title
        cell?.detailTextLabel?.text = book?.stringTags()
        
        // Devolverla
        return cell!
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // check what's the tag
        let tag = self.getTag(forSection: indexPath.section)
        
    
            // se comprueba el libro
            if let book = model.book(forTag: tag, at: indexPath.row) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    // Create BookViewController
                    let bookVC = BookViewController(model: book);
                    //Push it!!!
                    self.navigationController?.pushViewController(bookVC, animated: true)
                }else {
                    // Avisar al delegado
                    delegate?.libraryTableViewController(self, didSelectBook: book)
                    
                    // mandamos una notificación
                    notify(bookChanged: book)
                }
            }
        
    }
    
    //MARK: - Utils
    func getTag(forSection section: Int) -> Tag {
        
        return model.tags[section]
        
    }
}

//MARK: - LibraryTableViewControllerDelegate
protocol LibraryTableViewControllerDelegate : class {
    
    func libraryTableViewController(_ libraryVC: LibraryTableViewController, didSelectBook book: Book)
    
}


//MARK: - Notifications
extension LibraryTableViewController {
    
    func notify(bookChanged book : Book) {
        // Creamos una instancia del NotificationCenter
        let nc = NotificationCenter.default
        
        // Creas un objeto notificacion
        let notification = Notification(name: LibraryTableViewController.notificationName, object: self, userInfo: [LibraryTableViewController.bookKey : model])
        
        // Se manda
        nc.post(notification)
    }
    
    func subscribe(){
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: BookViewController.notificationName, object: nil, queue: OperationQueue.main, using: {(note: Notification) in self.reload()})
    }
}
