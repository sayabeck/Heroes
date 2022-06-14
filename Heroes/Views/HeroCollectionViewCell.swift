//
//  HeroCollectionViewCell.swift
//  Heroes
//
//  Created by mac mini on 6/6/22.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addActivityIndicator()
    }
    
    func configure(with hero: Hero?) {
        heroName.text = hero?.name
        
        NetworkManager.shared.fetchImage(from: hero?.images?.lg) { result in
            switch result {
            case .success(let imageData):
                self.activityIndicator.stopAnimating()
                self.heroImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addActivityIndicator() {
        heroImage.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: heroImage.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: heroImage.centerYAnchor).isActive = true
    }
}
