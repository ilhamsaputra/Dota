//
//  HeroCollectionViewCell.swift
//  Dota
//
//  Created by ilhamsaputra on 08/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import UIKit
import SDWebImage

class HeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setRoundedShadowView()
        self.heroImageView.setRoundedView()
    }
}

// MARK: - Setup UICollectionViewCell
extension HeroCollectionViewCell {

    func configureCell(hero: HeroModel){
        let imageUrl = Constant.BASE_URL + (hero.img ?? "")
        self.heroNameLabel.text = hero.localizedName
        self.heroImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "ic-placeholder"))
    }

}
