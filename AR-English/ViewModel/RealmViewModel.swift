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
    
    @Published var words: [Word] = []
    
    let config = Realm.Configuration(schemaVersion: 2)

    
    func saveWord(word: Word) {
        let realm = try! Realm(configuration: config)
        let newWord = DBWord()
        newWord.name = word.name
        newWord.translate = word.translate
        newWord.image = word.image
        newWord.priority = word.priority
        newWord.descriptin = word.descriptin
        
        let lst = List<Use>()
        
        for i in word.use {
            let u = Use()
            u.use_case = i.0
            u.use_translate = i.1
            lst.append(u)
        }
        
        newWord.use = lst
        
        try! realm.write {
            realm.add(newWord)
        }
    }
    
    func getWords() {
        let realm = try! Realm(configuration: config)
        words.removeAll()
        let dbWords = realm.objects(DBWord.self)
        
        for (index, word) in dbWords.enumerated() {
            var use: [(String, String)] = []
            for i in word.use {
                use.append((i.use_case, i.use_translate))
            }
            
            words.append(Word(id: index,
                              name: word.name,
                              translate: word.translate,
                              image: word.image,
                              priority: word.priority,
                              descriptin: word.descriptin,
                              use: use
                        ))
        }
    }
    
    func removeAll() {
        let realm = try! Realm(configuration: config)
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func checkWord(word: String) -> Bool {
        let realm = try! Realm(configuration: config)
        getWords()
        for w in words {
            if w.name == word {
                print(w.name)
                return false
            }
        }
        
        return true
    }
    
    
    
}