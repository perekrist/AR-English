//
//  WordViewController.swift
//  AR-English
//
//  Created by Кристина Перегудова on 21.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import UIKit
import RealityKit
import Combine
import ARKit

class WordViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    var word: String = "plane"
    
    var anchor: AnchorEntity = AnchorEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = try? ModelEntity.load(named: word)
        model?.setScale(SIMD3<Float>(0.003, 0.003, 0.003), relativeTo: self.anchor)
        
        let mesh = MeshResource.generateText(self.word)
        let color = UIColor.systemBlue
        let material = UnlitMaterial(color: color)
        let text = ModelEntity(mesh: mesh, materials: [material])
        text.setScale(SIMD3<Float>(0.004, 0.004, 0.004), relativeTo: self.anchor)
        text.setPosition(SIMD3<Float>(x: -0.01 * Float(word.count), y: -0.05, z: 0.0), relativeTo: self.anchor)
        text.generateCollisionShapes(recursive: true)
        
        anchor.addChild(model!)
        anchor.addChild(text)
        arView.scene.addAnchor(anchor)
        
    }
    
}
