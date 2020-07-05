//
//  NetworkViewModel.swift
//  AR-English
//
//  Created by Кристина Перегудова on 02.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkViewModel: ObservableObject {
    
    private var baseURL = ""
    
    func login(email: String, password: String) {
        AF.request(baseURL + "/login", parameters: ["user_name": email, "password": password]).responseJSON { (data) in
            let json = try! JSON(data: data.data!)
            
            if json["result"].stringValue == "OK" {
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        }
    }
    
    func register(email: String, password: String) {
        AF.request(baseURL + "/register", parameters: ["user_name": email, "password": password]).responseJSON { (data) in
            let json = try! JSON(data: data.data!)
            
            if json["result"].stringValue == "OK" {
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        }
    }
    
    
}
