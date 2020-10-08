//
//  Constant.swift
//  Dota
//
//  Created by ilhamsaputra on 08/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation
// MARK: - URL
class Constant {
    static let BASE_URL = "https://api.opendota.com"
    static let HERO_STATS = "/api/herostats"
    static let FAILED_REQUEST = "Network request failed."
}

// MARK: - Core Data
extension Constant{
    static let CORE_DATA_ENTITY = "HeroEntity"
    static let CORE_DATA_ID = "id"
    static let CORE_DATA_NAME = "name"
    static let CORE_DATA_LOCALIZE_NAME = "localizedName"
    static let CORE_DATA_PRIMARY_ATTRIBUTE = "primaryAttr"
    static let CORE_DATA_ATTACK_TYPE = "attackType"
    static let CORE_DATA_ROLES = "roles"
    static let CORE_DATA_IMAGE = "img"
    static let CORE_DATA_ICON = "icon"
    static let CORE_DATA_BASE_HEALTH = "baseHealth"
    static let CORE_DATA_BASE_MANA = "baseMana"
    static let CORE_DATA_BASE_ATTACK_MAX = "baseAttackMax"
    static let CORE_DATA_BASE_STR = "baseStr"
    static let CORE_DATA_BASE_AGI = "baseAgi"
    static let CORE_DATA_BASE_INT = "baseInt"
    static let CORE_DATA_MOVE_SPEED = "moveSpeed"
}

// MARK: - Color
extension Constant {
    static let BASE_COLOR = "#0076DE"
}

