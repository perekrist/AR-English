//
//  DBWord.swift
//  AR-English
//
//  Created by Кристина Перегудова on 02.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import RealmSwift

class DBWord: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var translate = ""
    @objc dynamic var image = ""
    @objc dynamic var priority = ""
    @objc dynamic var descriptin = ""
    var use = List<Use>()
}

class Use: Object {
    @objc dynamic var use_case = ""
    @objc dynamic var use_translate = ""
}
