//
//  RealmViewModel.swift
//  AR-English
//
//  Created by Кристина Перегудова on 02.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import RealmSwift


class RealmViewModel: ObservableObject {
    
    @Published var words: [DBWord] = []
    
    let realm = try! Realm()
    
    func saveWord(word: Word) {
        let newWord = DBWord()
        newWord.name = word.name
        newWord.translate = word.translate
        newWord.image = word.image
        newWord.priority = word.priority
        newWord.descriptin = word.descriptin
        newWord.use = word.use
        
        try! realm.write {
            realm.add(newWord)
        }
    }
    
    
    
}
