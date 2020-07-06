//
//  WordContainer.swift
//  AR-English
//
//  Created by Кристина Перегудова on 21.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import SwiftUI

struct WordContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Word", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Word")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}
