//
//  HeroModel.swift
//  Dota
//
//  Created by ilhamsaputra on 07/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation

struct HeroModel : Codable {
    let id : Int?
    let name : String?
    let localizedName : String?
    let primaryAttr : String?
    let attackType : String?
    let roles : [String]?
    let img : String?
    let icon : String?
    let baseHealth : Int?
    let baseMana : Int?
    let baseAttackMax : Int?
    let baseStr : Int?
    let baseAgi : Int?
    let baseInt : Int?
    let moveSpeed : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles = "roles"
        case img = "img"
        case icon = "icon"
        case baseHealth = "base_health"
        case baseMana = "base_mana"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case moveSpeed = "move_speed"
    }
    
    init(id:Int = 0, name:String = "", localizedName:String = "", primaryAttr:String = "", attackType:String = "", roles:[String] = [], img:String = "", icon:String = "", baseHealth:Int = 0, baseMana:Int = 0, baseAttackMax:Int = 0, baseStr:Int = 0, baseAgi:Int = 0, baseInt:Int = 0, moveSpeed:Int = 0) {
        self.id = id
        self.name = name
        self.localizedName = localizedName
        self.primaryAttr = primaryAttr
        self.attackType = attackType
        self.roles = roles
        self.img = img
        self.icon = icon
        self.baseHealth = baseHealth
        self.baseMana = baseMana
        self.baseAttackMax = baseAttackMax
        self.baseStr = baseStr
        self.baseAgi = baseAgi
        self.baseInt = baseInt
        self.moveSpeed = moveSpeed
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        localizedName = try values.decodeIfPresent(String.self, forKey: .localizedName)
        primaryAttr = try values.decodeIfPresent(String.self, forKey: .primaryAttr)
        attackType = try values.decodeIfPresent(String.self, forKey: .attackType)
        roles = try values.decodeIfPresent([String].self, forKey: .roles)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        baseHealth = try values.decodeIfPresent(Int.self, forKey: .baseHealth)
        baseMana = try values.decodeIfPresent(Int.self, forKey: .baseMana)
        baseAttackMax = try values.decodeIfPresent(Int.self, forKey: .baseAttackMax)
        baseStr = try values.decodeIfPresent(Int.self, forKey: .baseStr)
        baseAgi = try values.decodeIfPresent(Int.self, forKey: .baseAgi)
        baseInt = try values.decodeIfPresent(Int.self, forKey: .baseInt)
        moveSpeed = try values.decodeIfPresent(Int.self, forKey: .moveSpeed)
    }
}
