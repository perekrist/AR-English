//
//  ParseViewModel.swift
//  AR-English
//
//  Created by Кристина Перегудова on 05.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseViewModel: ObservableObject {
    
    var words: [Word] = []
    var tests: [Test] = []
    
    init() {
        parseWords()
        parseTests()
    }
    
    func parseWords() {
        let path = Bundle.main.path(forResource: "words", ofType: "json")
        if (path != nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let json = JSON(jsonResult)
                for j in json["words"] {
                    var use: [(String, String)] = []
                    for i in j.1["use"] {
                        use.append((i.1["use_case"].stringValue, i.1["use_translate"].stringValue))
                    }
                    words.append(Word(id: j.1["id"].intValue,
                                name: j.1["name"].stringValue,
                                translate: j.1["translate"].stringValue,
                                image: j.1["image"].stringValue,
                                priority: j.1["priority"].stringValue,
                                descriptin: j.1["descriptin"].stringValue,
                                use: use))
                }
            } catch {
                print("ParseViewModel(words): " + error.localizedDescription)
            }
        }
    }
    
    func parseTests() {
        let path = Bundle.main.path(forResource: "tests", ofType: "json")
        if (path != nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let json = JSON(jsonResult)
                for j in json["tests"] {
                    var answers: [String] = []
                    for i in (0 ..< j.1["answers"].count) {
                        answers.append(j.1["answers"][i].stringValue)
                    }
                    tests.append(Test(id: j.1["id"].intValue,
                                      difficulty: j.1["difficulty"].intValue,
                                      word: j.1["word"].stringValue,
                                      image: j.1["image"].stringValue,
                                      question: j.1["question"].stringValue,
                                      answers: answers,
                                      correct_answer: j.1["correct_answer"].stringValue))
                }
            } catch {
                print("ParseViewModel(tests): " + error.localizedDescription)
            }
        }
    }
}
