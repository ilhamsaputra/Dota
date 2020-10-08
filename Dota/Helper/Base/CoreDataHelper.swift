//
//  CoreDataHelper.swift
//  Dota
//
//  Created by ilhamsaputra on 08/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum EnumCoreDataOperation{
    case save
    case getAll
    case getHero
}

protocol CoreDataHelperDelegate: class {
    func successCoreData(_ type:EnumCoreDataOperation)
    func failureOperation()
}

class CoreDataHelper {
    
    var errorMessage:String = ""
    var heroId: Int = 0
    var hero:HeroModel?
    var heroList:[HeroModel] = []
    
    weak var delegate:CoreDataHelperDelegate?
    
    init(delegate: CoreDataHelperDelegate) {
        self.delegate = delegate
    }
    
    func convertDataHero(data:NSManagedObject) -> HeroModel{
        let arrayBack: [String] = try! JSONDecoder().decode([String].self, from: (data.value(forKey: Constant.CORE_DATA_ROLES) as? Data ?? Data()))
        let id = data.value(forKey: Constant.CORE_DATA_ID) as? Int
        let name = data.value(forKey: Constant.CORE_DATA_NAME) as? String
        let localizeName = data.value(forKey: Constant.CORE_DATA_LOCALIZE_NAME) as? String
        let primaryAttribute = data.value(forKey: Constant.CORE_DATA_PRIMARY_ATTRIBUTE) as? String
        let attackType = data.value(forKey: Constant.CORE_DATA_ATTACK_TYPE) as? String
        let roles = arrayBack
        let image = data.value(forKey: Constant.CORE_DATA_IMAGE) as? String
        let icon = data.value(forKey: Constant.CORE_DATA_ICON) as? String
        let baseHealth = data.value(forKey: Constant.CORE_DATA_BASE_HEALTH) as? Int
        let baseMana = data.value(forKey: Constant.CORE_DATA_BASE_MANA) as? Int
        let baseAttackMax = data.value(forKey: Constant.CORE_DATA_BASE_ATTACK_MAX) as? Int
        let baseStr = data.value(forKey: Constant.CORE_DATA_BASE_STR) as? Int
        let baseAgi = data.value(forKey: Constant.CORE_DATA_BASE_AGI) as? Int
        let baseInt = data.value(forKey: Constant.CORE_DATA_BASE_INT) as? Int
        let moveSpeed = data.value(forKey: Constant.CORE_DATA_MOVE_SPEED) as? Int
        
        return HeroModel(id: id ?? 0,
                         name: name ?? "",
                         localizedName: localizeName ?? "",
                         primaryAttr: primaryAttribute ?? "",
                         attackType: attackType ?? "",
                         roles: roles ,
                         img: image ?? "",
                         icon: icon ?? "",
                         baseHealth: baseHealth ?? 0,
                         baseMana: baseMana ?? 0,
                         baseAttackMax: baseAttackMax ?? 0,
                         baseStr: baseStr ?? 0,
                         baseAgi: baseAgi ?? 0,
                         baseInt: baseInt ?? 0,
                         moveSpeed: moveSpeed ?? 0)
    }
}


// MARK: - I&O Data
extension CoreDataHelper {
    func getAllHero() {
        self.heroList.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.CORE_DATA_ENTITY)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                self.heroList.append(self.convertDataHero(data: data))
            }
            self.delegate?.successCoreData(.getAll)
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            self.delegate?.failureOperation()
        }
    }
    
    func getHeroById(id:Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.CORE_DATA_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "\(Constant.CORE_DATA_ID) == \(id)")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                self.hero = self.convertDataHero(data: data)
            }
            self.delegate?.successCoreData(.getHero)
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            self.delegate?.failureOperation()
        }
    }
    
    func saveMovie(hero:HeroModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let heroEntity = NSEntityDescription.entity(forEntityName: Constant.CORE_DATA_ENTITY, in: managedContext)!
        let heroMO = NSManagedObject(entity: heroEntity, insertInto: managedContext)
        
        let rolesAsString: String = hero.roles?.description ?? ""
        let rolesAsData = rolesAsString.data(using: String.Encoding.utf16)
        
        heroMO.setValue(hero.id, forKeyPath: Constant.CORE_DATA_ID)
        heroMO.setValue(hero.name, forKeyPath: Constant.CORE_DATA_NAME)
        heroMO.setValue(hero.localizedName, forKeyPath: Constant.CORE_DATA_LOCALIZE_NAME)
        heroMO.setValue(hero.primaryAttr, forKeyPath: Constant.CORE_DATA_PRIMARY_ATTRIBUTE)
        heroMO.setValue(hero.attackType, forKeyPath: Constant.CORE_DATA_ATTACK_TYPE)
        heroMO.setValue(rolesAsData, forKeyPath: Constant.CORE_DATA_ROLES)
        heroMO.setValue(hero.img, forKeyPath: Constant.CORE_DATA_IMAGE)
        heroMO.setValue(hero.icon, forKeyPath: Constant.CORE_DATA_ICON)
        heroMO.setValue(hero.baseHealth, forKeyPath: Constant.CORE_DATA_BASE_HEALTH)
        heroMO.setValue(hero.baseMana, forKeyPath: Constant.CORE_DATA_BASE_MANA)
        heroMO.setValue(hero.baseAttackMax, forKeyPath: Constant.CORE_DATA_BASE_ATTACK_MAX)
        heroMO.setValue(hero.baseStr, forKeyPath: Constant.CORE_DATA_BASE_STR)
        heroMO.setValue(hero.baseAgi, forKeyPath: Constant.CORE_DATA_BASE_AGI)
        heroMO.setValue(hero.baseInt, forKeyPath: Constant.CORE_DATA_BASE_INT)
        heroMO.setValue(hero.moveSpeed, forKeyPath: Constant.CORE_DATA_MOVE_SPEED)
        
        do {
            try managedContext.save()
            self.delegate?.successCoreData(.save)
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            self.delegate?.failureOperation()
        }
    }
    
    func deleteAllHero(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.CORE_DATA_ENTITY)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            self.delegate?.failureOperation()
        }
    }
}
