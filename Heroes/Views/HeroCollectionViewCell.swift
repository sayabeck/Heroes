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
    
    func configure(with hero: Hero?) {
        heroName.text = hero?.name
        
        NetworkManager.shared.fetchImage(from: hero?.images?.xs) { result in
            switch result {
            case .success(let imageData):
                self.heroImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
