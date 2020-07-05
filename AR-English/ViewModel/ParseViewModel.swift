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
    
    var word: Word?
    
    init() {
        let path = Bundle.main.path(forResource: "words", ofType: "json")
        if (path != nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let json = JSON(jsonResult)
                var use: [(String, String)] = []
                for i in json["words"][0]["use"] {
                    use.append((i.1["use_case"].stringValue, i.1["use_translate"].stringValue)) 
                }
                word = Word(id: json["words"][0]["id"].intValue,
                            name: json["words"][0]["name"].stringValue,
                            translate: json["words"][0]["translate"].stringValue,
                            image: json["words"][0]["image"].stringValue,
                            priority: json["words"][0]["priority"].stringValue,
                            descriptin: json["words"][0]["descriptin"].stringValue,
                            use: use)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
