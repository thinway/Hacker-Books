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
    }
    
    //MARK: - Sync model -> View
    func syncViewWithModel() {
        bookCover.image = model.cover
        title = model.title
    }
    
    //MARK - Actions
    @IBAction func readBook(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func toggleFavourite(_ sender: UIBarButtonItem) {
    }
}
