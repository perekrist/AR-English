//
//  Test.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 16.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import Foundation

struct Test: Identifiable {
    var id: Int
    var difficulty: Int
    var word: String
    var image: String
    var question: String
    var answers: [String]
    var correct_answer: Int
}
