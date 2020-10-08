//
//  DetailHeroViewController.swift
//  Dota
//
//  Created by ilhamsaputra on 09/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import UIKit

class DetailHeroViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var typeAttackImageView: UIImageView!
    @IBOutlet weak var typeAttackLabel: UILabel!
    @IBOutlet weak var baseStrLabel: UILabel!
    @IBOutlet weak var baseAgiLabel: UILabel!
    @IBOutlet weak var baseintLabel: UILabel!
    @IBOutlet weak var baseHealthLabel: UILabel!
    @IBOutlet weak var maxAttackLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy private var coredataHelper:CoreDataHelper = CoreDataHelper(delegate: self)
    private var viewModel = DetailHeroViewModel()
    
    convenience init(hero:HeroModel) {
        self.init()
        self.viewModel.heroModel = hero
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCollectionView()
        self.initView()
        self.initData()
        
    }
}

// MARK: - Init UI and Data
extension DetailHeroViewController {
    func initView() {
        self.title = self.viewModel.heroModel.localizedName
        self.containerView.setRoundedShadowView()
    }
    
    func initData() {
        self.coredataHelper.getAllHero()
        
        self.heroImageView.sd_setImage(with: URL(string: Constant.BASE_URL + (self.viewModel.heroModel.icon ?? "")), placeholderImage: UIImage(named: "ic-paceholder-hero"))
        self.heroNameLabel.text = self.viewModel.heroModel.localizedName
        self.typeAttackLabel.text = self.viewModel.heroModel.attackType
        self.typeAttackImageView.image = self.viewModel.heroModel.attackType == "Melee" ? UIImage(named: "ic-melee") : UIImage(named: "ic-range")
        self.baseStrLabel.text = "\(self.viewModel.heroModel.baseStr ?? 0)"
        self.baseAgiLabel.text = "\(self.viewModel.heroModel.baseAgi ?? 0)"
        self.baseintLabel.text = "\(self.viewModel.heroModel.baseInt ?? 0)"
        self.baseHealthLabel.text = "\(self.viewModel.heroModel.baseHealth ?? 0)"
        self.maxAttackLabel.text = "\(self.viewModel.heroModel.baseAttackMax ?? 0)"
        self.speedLabel.text = "\(self.viewModel.heroModel.moveSpeed ?? 0)"
        self.roleLabel.text = self.viewModel.heroModel.roles?.joined(separator: ",")
    }
    
    func initCollectionView(){
        collectionView.register(UINib(nibName: "HeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeroCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16);
    }
}

// MARK: - Action And Method
extension DetailHeroViewController {
    
    func showAlert(title: String = "Information", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - UICollectionView
extension DetailHeroViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.similarHeroModel.count < 3 ? self.viewModel.similarHeroModel.count : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as? HeroCollectionViewCell
        let hero = self.viewModel.similarHeroModel[indexPath.row]
        cell?.configureCell(hero: hero)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = self.viewModel.similarHeroModel[indexPath.row]
        let vc = DetailHeroViewController(hero: hero)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 185)
    }
}

// MARK: - Core Data Delegate
extension DetailHeroViewController: CoreDataHelperDelegate {
    func successCoreData(_ type: EnumCoreDataOperation) {
        switch type {
        case .getAll:
            self.viewModel.similarHeroModel = self.coredataHelper.heroList
            self.viewModel.createSimilarHero()
            self.collectionView.reloadData()
        default:
            break
        }
    }
    
    func failureOperation() {
        self.showAlert(message: self.coredataHelper.errorMessage)
    }
}

