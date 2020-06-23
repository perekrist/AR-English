//
//  ARMemoViewController.swift
//  AR-English
//
//  Created by Кристина Перегудова on 13.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import UIKit
import RealityKit
import Combine
import ARKit
import MultipeerConnectivity

class ARMemoViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    
    var multipeerSession: MultipeerSession?
    
    let coachingOverlay = ARCoachingOverlayView()
    
    // A dictionary to map MultiPeer IDs to ARSession ID's.
    // This is useful for keeping track of which peer created which ARAnchors.
    var peerSessionIDs = [MCPeerID: String]()
    
    var sessionIDObservation: NSKeyValueObservation?
    
    var configuration: ARWorldTrackingConfiguration?
    
    // Session Card Pic
    var firstCardPick: Entity? = nil
    var secondCardPick: Entity? = nil
    
    @IBOutlet weak var pairsInfo: UILabel!
    var pairsDone = 0
    
    // Create Cards
    var allCards: [Entity] = []
    var cardTemplates: [Entity] = []
    
    var words: [String] = ["car", "plane", "solider", "robot", "car", "plane", "solider", "robot"]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        arView.session.delegate = self

        // Turn off ARView's automatically-configured session
        // to create and set up your own configuration.
        arView.automaticallyConfigureSession = false
        
        configuration = ARWorldTrackingConfiguration()

        // Enable a collaborative session.
        configuration?.isCollaborationEnabled = true
        
        // Enable realistic reflections.
        configuration?.environmentTexturing = .automatic

        // Begin the session.
        arView.session.run(configuration!)
        
        // Use key-value observation to monitor your ARSession's identifier.
        sessionIDObservation = observe(\.arView.session.identifier, options: [.new]) { object, change in
            print("SessionID changed to: \(change.newValue!)")
            // Tell all other peers about your ARSession's changed ID, so
            // that they can keep track of which ARAnchors are yours.
            guard let multipeerSession = self.multipeerSession else { return }
            self.sendARSessionIDTo(peers: multipeerSession.connectedPeers)
        }
        
        // Start looking for other players via MultiPeerConnectivity.
        multipeerSession = MultipeerSession(receivedDataHandler: receivedData, peerJoinedHandler:
                                            peerJoined, peerLeftHandler: peerLeft, peerDiscoveredHandler: peerDiscovered)
        
        // Prevent the screen from being dimmed to avoid interrupting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func placeBoard() {
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
    
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let participantAnchor = anchor as? ARParticipantAnchor {

                let anchorEntity = AnchorEntity(anchor: participantAnchor)
                
                let coordinateSystem = MeshResource.generateCoordinateSystemAxes()
                anchorEntity.addChild(coordinateSystem)
                
                let color = participantAnchor.sessionIdentifier?.toRandomColor() ?? .white
                let coloredSphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.03),
                                                materials: [SimpleMaterial(color: color, isMetallic: true)])
                anchorEntity.addChild(coloredSphere)
                
                arView.scene.addAnchor(anchorEntity)
            }
        }
        
    }
    
    /// - Tag: DidOutputCollaborationData
    func session(_ session: ARSession, didOutputCollaborationData data: ARSession.CollaborationData) {
        guard let multipeerSession = multipeerSession else { return }
        if !multipeerSession.connectedPeers.isEmpty {
            guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            else { fatalError("Unexpectedly failed to encode collaboration data.") }
            // Use reliable mode if the data is critical, and unreliable mode if the data is optional.
            let dataIsCritical = data.priority == .critical
            multipeerSession.sendToAllPeers(encodedData, reliably: dataIsCritical)
        } else {
            print("Deferred sending collaboration to later because there are no peers.")
        }
    }

    func receivedData(_ data: Data, from peer: MCPeerID) {
        if let collaborationData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARSession.CollaborationData.self, from: data) {
            arView.session.update(with: collaborationData)
            return
        }

        let sessionIDCommandString = "SessionID:"
        if let commandString = String(data: data, encoding: .utf8), commandString.starts(with: sessionIDCommandString) {
            let newSessionID = String(commandString[commandString.index(commandString.startIndex,
                                                                     offsetBy: sessionIDCommandString.count)...])
            // If this peer was using a different session ID before, remove all its associated anchors.
            // This will remove the old participant anchor and its geometry from the scene.
            if let oldSessionID = peerSessionIDs[peer] {
                removeAllAnchorsOriginatingFromARSessionWithID(oldSessionID)
            }
            
            peerSessionIDs[peer] = newSessionID
        }
    }
    
    func peerDiscovered(_ peer: MCPeerID) -> Bool {
        guard let multipeerSession = multipeerSession else { return false }
        
        if multipeerSession.connectedPeers.count > 1 {
            // Do not accept more than 2 users in the experience.
            return false
        } else {
            return true
        }
    }
    /// - Tag: PeerJoined
    func peerJoined(_ peer: MCPeerID) {
        // Provide your session ID to the new user so they can keep track of your anchors.
        sendARSessionIDTo(peers: [peer])
    }
        
    func peerLeft(_ peer: MCPeerID) {        
        // Remove all ARAnchors associated with the peer that just left the experience.
        if let sessionID = peerSessionIDs[peer] {
            removeAllAnchorsOriginatingFromARSessionWithID(sessionID)
            peerSessionIDs.removeValue(forKey: peer)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        // Remove optional error messages.
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            // Present the error that occurred.
            let alertController = UIAlertController(title: "The AR session failed.", message: errorMessage, preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
                self.resetTracking()
            }
            alertController.addAction(restartAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        // Request that iOS hide the status bar to improve immersiveness of the AR experience.
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        // Request that iOS hide the home indicator to improve immersiveness of the AR experience.
        return true
    }
    
    private func removeAllAnchorsOriginatingFromARSessionWithID(_ identifier: String) {
        guard let frame = arView.session.currentFrame else { return }
        for anchor in frame.anchors {
            guard let anchorSessionID = anchor.sessionIdentifier else { continue }
            if anchorSessionID.uuidString == identifier {
                arView.session.remove(anchor: anchor)
            }
        }
    }
    
    private func sendARSessionIDTo(peers: [MCPeerID]) {
        guard let multipeerSession = multipeerSession else { return }
        let idString = arView.session.identifier.uuidString
        let command = "SessionID:" + idString
        if let commandData = command.data(using: .utf8) {
            multipeerSession.sendToPeers(commandData, reliably: true, peers: peers)
        }
    }
    
    func resetTracking() {
        guard let configuration = arView.session.configuration else { print("A configuration is required"); return }
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}


