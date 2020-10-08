//
//  UIView.swift
//  Dota
//
//  Created by ilhamsaputra on 08/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func setRoundedView(){
        self.layer.cornerRadius = 8
    }
    
    func setRoundedShadowView(){
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1
    }
}
