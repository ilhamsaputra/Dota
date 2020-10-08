//
//  HomeViewController.swift
//  Dota
//
//  Created by ilhamsaputra on 06/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy private var viewModel:HomeViewModel = HomeViewModel(delegate: self)
    lazy private var coredataHelper:CoreDataHelper = CoreDataHelper(delegate: self)
    
    var refreshControl:UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initCollectionView()
        self.initData()
        self.initRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Init UI and Data
extension HomeViewController {
    func initView() {
        self.viewModel.selectedRole = "All"
        self.title = self.viewModel.selectedRole
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-filter"), style:.plain, target: self, action: #selector(onFilterPressed))
    }
    
    func initCollectionView(){
        collectionView.register(UINib(nibName: "HeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeroCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func initData() {
        coredataHelper.getAllHero()
    }
    
    func initRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        self.viewModel.getHeroList()
    }
}

// MARK: - Action And Method
extension HomeViewController {
    
    @objc func onFilterPressed() {
        let vc = FilterRolesViewController(roles: self.viewModel.filterRole)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String = "Information", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Home ViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    func showSpinner() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func removeSpinner() {
        self.refreshControl.endRefreshing()
        self.activityIndicator.stopAnimating()
    }
}

// MARK: - Home ViewModel Response
extension HomeViewController: HomeViewModelResponse {
    func successGetHeroList() {
        self.coredataHelper.deleteAllHero()
        self.viewModel.heroListModel.forEach { (heroModel) in
            self.coredataHelper.saveMovie(hero: heroModel)
        }
        self.viewModel.createRolesFilter()
        self.collectionView.reloadData()
    }
    
    func errorGetHeroList() {
        self.showAlert(message: self.viewModel.errorMessage)
    }
}

// MARK: - Core Data Delegate
extension HomeViewController: CoreDataHelperDelegate {
    func successCoreData(_ type: EnumCoreDataOperation) {
        switch type {
        case .getAll:
            if self.coredataHelper.heroList.count > 0 {
                self.viewModel.heroListModel = self.coredataHelper.heroList
            }else {
                self.viewModel.getHeroList()
            }
            self.viewModel.createRolesFilter()
            self.collectionView.reloadData()
        default:
             break
        }
    }
    
    func failureOperation() {
        self.showAlert(message: self.coredataHelper.errorMessage)
    }
}

// MARK: - UICollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.heroListModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as? HeroCollectionViewCell
        let hero = self.viewModel.heroListModel[indexPath.row]
        cell?.configureCell(hero: hero)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let sizeWidth = Int(((UIScreen.main.bounds.width - 32) - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: sizeWidth, height: sizeWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = self.viewModel.heroListModel[indexPath.row]
        let vc = DetailHeroViewController(hero: hero)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Filter Roles Delegate
extension HomeViewController: FilterRolesViewControllerDelegate {
    func selectedRole(role: String) {
        guard self.viewModel.selectedRole != role else { return }
        self.viewModel.selectedRole = role
        self.title = self.viewModel.selectedRole
        if role == "All" {
            self.coredataHelper.getAllHero()
        }else{
            self.coredataHelper.getAllHero()
            self.viewModel.filterHeroList()
            self.collectionView.reloadData()
        }
    }
}









