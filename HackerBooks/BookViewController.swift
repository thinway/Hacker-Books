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
    let model : Book
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
        
    }
}
