//
//  VisionViewController.swift
//  AR-English
//
//  Created by Кристина Перегудова on 10.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import SwiftUI

struct VisionViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VisionViewController>) -> VisionViewController.UIViewControllerType {
        
        let storyboard = UIStoryboard(name: "VisionScreen", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "VisionScreen")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<VisionViewController>) {
        
    }
    
    
    
}
