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
    
    init() {
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
                print("ParseViewModel: " + error.localizedDescription)
            }
        }
    }
}
