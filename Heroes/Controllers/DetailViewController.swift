//
//  DetailViewController.swift
//  Heroes
//
//  Created by mac mini on 6/8/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var hero: Hero!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var detailInfoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = hero.name

    }

}
