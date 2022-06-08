//
//  HeroTableView.swift
//  Heroes
//
//  Created by mac mini on 6/9/22.
//

import UIKit

class HeroTableView: UITableView {

    var height: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if let heroImage = header.subviews.first as? UIImageView {
            height = heroImage.constraints.filter { $0.identifier == "height" }.first
            bottom = header.constraints.filter { $0.identifier == "bottom" }.first
        }
        
        let offsetY = -contentOffset.y
        bottom?.constant = offsetY >= 0 ? 0 : offsetY / 2
        height?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        
        header.clipsToBounds = offsetY <= 0
    }
}
