//
//  Word.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import Foundation

struct Word: Identifiable {
    var id: Int
    var name: String
    var translate: String
    var image: String
    var priority: String
    var descriptin: String
    var use: [(String, String)]
}
