//
//  DBChild.swift
//  AR-English
//
//  Created by Кристина Перегудова on 06.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import RealmSwift

class DBChild: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var sex = ""
    @objc dynamic var birthday = 0
}
