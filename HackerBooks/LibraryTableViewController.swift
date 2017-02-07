//
//  LibraryTableViewController.swift
//  HackerBooks
//
//  Created by Fran Delgado on 6/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    //MARK: - Properties
    let model: Library
    
    //MARK: - Initialization
    init(model: Library) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        // check what's the book
        let book = model.book(forTag: tag, at: indexPath.row)
        
        // Create BookViewController
        let bookVC = BookViewController(model: book!);
        
        // Push it!!!
        self.navigationController?.pushViewController(bookVC, animated: true)
        
    }
    
    //MARK: - Utils
    func getTag(forSection section: Int) -> Tag {
        
        return model.tags[section]
        
    }
}
