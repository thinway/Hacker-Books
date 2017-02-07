//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Fran Delgado on 7/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    //MARK: - Properties
    var model : Book
    
    static let notificationName = Notification.Name(rawValue: "toogleFavourite")

    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var favBarButton: UIBarButtonItem!
    
    //MARK: - Initialization
    
    init(model: Book) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        syncViewWithModel()
        
        edgesForExtendedLayout = .all
        
    }
    
    //MARK: - Sync model -> View
    func syncViewWithModel() {
        
        bookCover.image = model.cover
        title = model.title
        favBarButton.title = self.model.isFavourite ? "Unfavourite" : "Favourite"
        
    }
    
    //MARK - Actions
    @IBAction func readBook(_ sender: UIBarButtonItem) {
        
        // Create a readBookViewController
        let rbVC = readBookViewController(model: model)
        
        navigationController?.pushViewController(rbVC, animated: true)
        
    }
    
    @IBAction func toggleFavourite(_ sender: UIBarButtonItem) {
        
        let fav = self.model.isFavourite
        
        self.model.isFavourite = !fav
        
        favBarButton.title = self.model.isFavourite ? "Unfavourite" : "Favourite"
        
        //print(model.tags)
        // Se notifica que el usuario ha tocado en favorito
        notify()
    }
}


extension BookViewController {
    
    // Notificación cuando un usuario toca el botón favorito
    func notify() {
        let nc = NotificationCenter.default
        let notification = Notification(name: BookViewController.notificationName, object: self, userInfo: nil)
        nc.post(notification)
        
    }
}


//MARK: - LibraryTableViewControllerDelegate
extension BookViewController : LibraryTableViewControllerDelegate {
    
    func libraryTableViewController(_ libraryVC: LibraryTableViewController, didSelectBook book: Book) {
        
        // Change the model
        model = book
        
        syncViewWithModel()
    }
}
