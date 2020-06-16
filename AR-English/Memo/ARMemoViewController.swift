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
    
    // Session Card Pic
    var firstCardPick: Entity? = nil
    var secondCardPick: Entity? = nil
    
    @IBOutlet weak var pairsInfo: UILabel!
    var pairsDone = 0
    
    // Create Cards
    var allCards: [Entity] = []
    var cardTemplates: [Entity] = []
    
    var words: [String] = ["car", "plane", "solider", "robot", "car", "plane", "solider", "robot"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Add anchorentity to arView scene
        // Create an anchor for a horizontal plane with a minimum area of 20 cm^2
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2 ,0.2])
        arView.scene.addAnchor(anchor)
        
        // MARK: Create Card
        for index in 0 ..< self.words.count {
            // Create card box
            let box = MeshResource.generateBox(width: 0.04, height: 0.002, depth: 0.04)
            // Create material
            let metalMaterial = SimpleMaterial(color: .gray, isMetallic: true)
            // Create ModelEntity using mesh and materials
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            // Generate collision shapes for the card so we can interact with it
            model.generateCollisionShapes(recursive: true)
            // Give the card a name so we'll know what we're interacting with
            model.name = words[index]
            
            for _ in 1...2 {
                allCards.append(model.clone(recursive: true))
            }
            
        }
        
        // MARK: OcclusionBox
        // Create plane mesh, 0.5 meters wide & 0.5 meters deep
        let boxSize: Float = 0.5
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        
        // Create occlusion material
        let material = OcclusionMaterial()
        
        // Create ModelEntity using mesh and materials
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [material])
        
        // Position plane below game board
        occlusionBox.position.y = -boxSize / 2
        
        // Add to anchor
        anchor.addChild(occlusionBox)
        
        // MARK: Load model cardTemplates
        // Load the model asset for each card synchronous
        for index in 0 ..< self.words.count {
            let assetName = words[index]
            let cardTemplate = try! Entity.loadModel(named: assetName)
            
            // Set size of cardTemplate
            cardTemplate.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: anchor)
            
            cardTemplates.append(cardTemplate)
            
            let mesh = MeshResource.generateText(self.words[index])
            let color = #colorLiteral(red: 1, green: 0.9605560323, blue: 0, alpha: 1)
            let material = UnlitMaterial(color: color)
            let textEntity = ModelEntity(mesh: mesh, materials: [material])
            textEntity.setScale(SIMD3<Float>(0.0015, 0.0015, 0.0015), relativeTo: anchor)
            textEntity.generateCollisionShapes(recursive: true)
            textEntity.name = words[index]
            
            cardTemplates.append(textEntity)
        }
        
        // MARK: Set cardTemplate to card
        for (index, cardTemplate) in cardTemplates.enumerated() {
            // Add cardTemplate model to card
            allCards[index].addChild(cardTemplate)
            // Set the card to rotate back to 180 degrees
            allCards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
        }
        
        // MARK: Add card to AnchorEntity
        // Shuffle the cards so they are randomly ordered
        allCards.shuffle()
        
        // Position the shuffled cards in a 4-by-4 grid
        for (index, card) in allCards.enumerated() {
            let x = Float(index % 4) - 1.5
            let z = Float(index / 4) - 1.5
            
            // Set the position of the card
            card.position = [x * 0.1, 0, z * 0.1]
            
            // Add the card to the anchor
            print("show card")
            anchor.addChild(card)
        }
        
    }
    
    // Hit Testing
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        
        // Get the entity at the location we've tapped, if one exists
        if let card = arView.entity(at: tapLocation) {
            flipCard(card: card, angle: 0)
            if firstCardPick !== nil {
                secondCardPick = card
                print("sccond card pick : \(String(describing: secondCardPick?.name ?? "no card"))")
            } else {
                firstCardPick = card
                print("first card pick : \(String(describing: firstCardPick?.name ?? "no card"))")
            }
            if (firstCardPick != nil && secondCardPick != nil) {
                chackPair()
            }
        }
    }
    
    func chackPair() {
        print("first card check: \(String(describing: firstCardPick?.name ?? "no card"))")
        print("sccond card check: \(String(describing: secondCardPick?.name ?? "no card"))")
        
        if (firstCardPick?.name == secondCardPick?.name) {
            print("Pair!!")
            // delay 1 second
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // remove card
                self.firstCardPick?.removeFromParent()
                self.secondCardPick?.removeFromParent()
                
                // clear card piker
                self.firstCardPick = nil
                self.secondCardPick = nil
                
                self.pairsDone += 1
                self.pairsInfo.text = "Pairs: \(self.pairsDone) / 8"
            }
        } else {
            // clear card piker
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // remove card
                self.flipCard(card: self.firstCardPick!, angle: .pi)
                self.flipCard(card: self.secondCardPick!, angle: .pi)
                // clear card piker
                self.firstCardPick = nil
                self.secondCardPick = nil
            }
        }
    }
    
    func flipCard(card: Entity, angle: Float) {
        var flipTransform = card.transform
        // Set the card to rotate back to angle degrees in x axis
        flipTransform.rotation = simd_quatf(angle: angle, axis: [1, 0, 0])
        
        card.move(to: flipTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
    }
    
}


