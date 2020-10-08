//
//  HomeViewModel.swift
//  Dota
//
//  Created by ilhamsaputra on 06/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation

protocol HomeViewModelResponse: class {
    func successGetHeroList()
    func errorGetHeroList()
}

protocol HomeViewModelDelegate: HomeViewModelResponse {
    func showSpinner()
    func removeSpinner()
}

class HomeViewModel {
    let homeService = HomeService()
    var heroListModel:[HeroModel] = [HeroModel]()
    var filterRole:[String] = []
    var selectedRole:String = ""
    var errorMessage:String = ""
    
    weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Request Hero List
extension HomeViewModel {

    func getHeroList() {
        self.delegate?.showSpinner()
        homeService.url = Constant.BASE_URL +  Constant.HERO_STATS
        BaseNetwork.request(req: homeService) { (result) in
            self.delegate?.removeSpinner()
            switch result {
            case .success(let response):
                self.heroListModel = response
                self.delegate?.successGetHeroList()
            case .failure(let error):
                self.errorMessage = error 
                self.delegate?.errorGetHeroList()
            }
        }
    }
}

// MARK: - Manipulate Date
extension HomeViewModel {
    
    // create list role heros for filter
    func createRolesFilter() {
        var joinedArray:[[String]] = []
        self.heroListModel.forEach { (heroModel) in
            joinedArray.append(heroModel.roles ?? [])
        }
        self.filterRole = Array(Set(joinedArray.flatMap { $0 }))
        self.filterRole.insert("All", at: 0)
    }
    
    // filter hero list with selected role
    func filterHeroList(){
         self.heroListModel = self.heroListModel.filter { ($0.roles?.contains(self.selectedRole) ?? false) }
    }
}
