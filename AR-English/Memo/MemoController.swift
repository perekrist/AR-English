//
//  MemoController.swift
//  AR-English
//
//  Created by Кристина Перегудова on 13.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Memo", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Memo")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}
