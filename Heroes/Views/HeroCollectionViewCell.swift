//
//  HeroCollectionViewCell.swift
//  Heroes
//
//  Created by mac mini on 6/6/22.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: HeroImageView!
    @IBOutlet weak var heroName: UILabel!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heroImage.addSubview(activityIndicator)
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: heroImage.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: heroImage.centerYAnchor).isActive = true
        
    }
    
    func configure(with hero: Hero?) {
        heroName.text = hero?.name
        heroImage.fetchImage(from: hero?.images?.lg ?? "")
    }
    
}
