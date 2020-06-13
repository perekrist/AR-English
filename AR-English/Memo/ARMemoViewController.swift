//
//  MemoController.swift
//  AR-English
//
//  Created by Кристина Перегудова on 13.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import UIKit
import RealityKit
import Combine

class ARMemoViewController: UIViewController {

    @IBOutlet var arView: ARView!
    var words: [String] = ["car", "plane", "solider", "robot", "car", "plane", "solider", "robot"]
        
    var anchor: AnchorEntity = AnchorEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
        arView.scene.addAnchor(anchor)
        
        var cards: [Entity] = []
        
         for _ in 1...16 {
            let box = MeshResource.generateBox(width: 0.04, height: 0.002, depth: 0.04)
            let metalMaterial = SimpleMaterial(color: .gray, isMetallic: true)
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
                    
            model.generateCollisionShapes(recursive: true)
            cards.append(model)
        }
        
        for (index, card) in cards.enumerated() {
            let x = Float(index % 4) - 1.5
            let z = Float(index / 4) - 1.5
            
            card.position = [x * 0.1, 0, z * 0.1]
            
            anchor.addChild(card)
        }
        
        // hide 3d models when card flip down
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        occlusionBox.position.y = -boxSize / 2 - 0.001
        anchor.addChild(occlusionBox)
        
        var cancellable: AnyCancellable? = nil
        cancellable = ModelEntity.loadModelAsync(named: words[0])
            .append(ModelEntity.loadModelAsync(named: words[1]))
            .append(ModelEntity.loadModelAsync(named: words[2]))
            .append(ModelEntity.loadModelAsync(named: words[3]))
            .append(ModelEntity.loadModelAsync(named: words[4]))
            .append(ModelEntity.loadModelAsync(named: words[5]))
            .append(ModelEntity.loadModelAsync(named: words[6]))
            .append(ModelEntity.loadModelAsync(named: words[7]))
            .collect()
            .sink(receiveCompletion: { error in
                print("Error: \(error)")
                cancellable?.cancel()
            }, receiveValue: { entities in
                var objects: [ModelEntity] = []
                for index in 0 ..< entities.count {
                    // add 3d model
                    let entity = entities[index]
                    entity.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: self.anchor)
                    entity.generateCollisionShapes(recursive: true)
                    objects.append(entity.clone(recursive: true))
                    
                    // add 3d text
                    let mesh1 = MeshResource.generateText(self.words[index])
                    let color1 = UIColor.systemBlue
                    let material1 = UnlitMaterial(color: color1)
                    let entity1 = ModelEntity(mesh: mesh1, materials: [material1])
                    entity1.setScale(SIMD3<Float>(0.0015, 0.0015, 0.0015), relativeTo: self.anchor)
                    entity1.generateCollisionShapes(recursive: true)
                    objects.append(entity1)
                }
                // shuffle cards
                objects.shuffle()
                        
                for (index, objects) in objects.enumerated() {
                    cards[index].addChild(objects)
                    cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
                }
                
                cancellable?.cancel()
            })
    }
        
    
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        if let card = arView.entity(at: tapLocation) {
            if card.transform.rotation.angle == .pi {
                var flipDownTransform = card.transform
                flipDownTransform.rotation = simd_quatf(angle: 0, axis: [1, 0, 0])
                card.move(to: flipDownTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
            } else {
                var flipUpTransform = card.transform
                flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
                card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
            }
        }
    }

}

