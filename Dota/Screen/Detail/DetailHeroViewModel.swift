//
//  DetailHeroViewModel.swift
//  Dota
//
//  Created by ilhamsaputra on 09/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation

class DetailHeroViewModel {
   
    var similarHeroModel:[HeroModel] = [HeroModel]()
    var heroModel:HeroModel = HeroModel()
}

// MARK: - create simmilar heroes
extension DetailHeroViewModel {
    func createSimilarHero() {
        
        // finding same primary attribute
        self.similarHeroModel = self.similarHeroModel.filter { ($0.primaryAttr == self.heroModel.primaryAttr) }
        
        // sort ranking conform with primary attribute
        switch self.heroModel.primaryAttr {
        case "str":
            self.similarHeroModel = self.similarHeroModel.sorted { ($0.baseAttackMax ?? 0 > $1.baseAttackMax ?? 0) }
        case "agi":
             self.similarHeroModel = self.similarHeroModel.sorted { ($0.moveSpeed ?? 0 > $1.moveSpeed ?? 0) }
        case "int":
            self.similarHeroModel = self.similarHeroModel.sorted { ($0.baseMana ?? 0 > $1.baseMana ?? 0) }
        default:
            break
        }
        
        // make sure similar dont show the same hero with hero opened
        self.similarHeroModel = self.similarHeroModel.filter{ ($0.id != self.heroModel.id) }
    }
}
