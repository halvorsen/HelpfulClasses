//
//  ViewController.swift
//  MeVsBlock
//
//  Created by Aaron Halvorsen on 9/25/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARKitViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var wrapper = SCNNode()
    var playerNode = SCNNode()
    var tracks = [SCNNode]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/track.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.scene.physicsWorld.contactDelegate = self
        
        wrapper = scene.rootNode.childNode(withName: "wrapper", recursively: false)!
        playerNode = scene.rootNode.childNode(withName: "playerNode", recursively: false)!
        tracks = [
           wrapper.childNode(withName: "track1", recursively: false)!,
           wrapper.childNode(withName: "track2", recursively: false)!,
           wrapper.childNode(withName: "track3", recursively: false)!
        ]
        playerNode.removeFromParentNode()
        sceneView.pointOfView?.addChildNode(playerNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let action = SCNAction.move(by: SCNVector3(0,0,40), duration: 20.0)
        action.timingMode = .easeInEaseOut
        wrapper.runAction(action)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        if (contact.nodeA.physicsBody!.categoryBitMask == 1 | 2 {
            
            if contact.nodeA.name == "track1" || contact.nodeA.name == "track2" || contact.nodeA.name == "track3" {
                switch contact.nodeA.name! {
                case "track1":
                    tracks[1].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                    tracks[2].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                case "track2":
                    tracks[0].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                    tracks[2].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                case "track3":
                    tracks[0].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                    tracks[1].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                default: break
                }
                contact.nodeA.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
            } else if contact.nodeB.name == "track1" || contact.nodeB.name == "track2" || contact.nodeB.name == "track3" {
                switch contact.nodeA.name! {
                case "track1":
                    tracks[1].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                    tracks[2].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                case "track2":
                    tracks[0].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                    tracks[2].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                case "track3":
                    tracks[0].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                    tracks[1].geometry?.firstMaterial?.diffuse.contents = UIColor.black
                default: break
                }
                contact.nodeB.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
            }
            
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
