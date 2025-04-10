//
//  ViewController.swift
//  ArDice
//
//  Created by viraj shah on 10/04/25.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    var diceArray = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // Set the view's delegate
        sceneView.delegate = self
        
        //        Adding moon to our gallery
        
        //                let sphere = SCNSphere(radius: 0.2)
        //
        //                let material = SCNMaterial()
        //                material.diffuse.contents = UIImage(named: "art.scnassets/8k_moon.jpg")
        //
        //                sphere.materials = [material]
        //
        //                let node = SCNNode()
        //
        //                node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        //
        //                node.geometry = sphere
        //
        //                sceneView.scene.rootNode.addChildNode(node)
        //
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        // Create a new scene
        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        //
        //        // Create a new scene
        //                let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        //
        //                if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true)
        //                {
        //                    diceNode.position = SCNVector3(x: 0, y: 0, z: -0.1)
        //
        //                    sceneView.scene.rootNode.addChildNode(diceNode)
        //                }
        //        sceneView.autoenablesDefaultLighting = true
        
        
        // Set the scene to the view
        //        sceneView.scene = scene
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor{
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x:planeAnchor.center.x,y:0,z:planeAnchor.center.z)
            
            planeNode.transform = SCNMatrix4Rotate(SCNMatrix4Identity, -Float.pi / 2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            
        }
        else{
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: sceneView)
        
        // Create raycast query
        guard let query = sceneView.raycastQuery(from: touchLocation,
                                                 allowing: .existingPlaneGeometry,
                                                 alignment: .any) else {
            print("Failed to create raycast query")
            return
        }
        
        // Perform raycast
        let results = sceneView.session.raycast(query)
        
        if let result = results.first {
            print("Touched the plane at: \(result)")
            
            //        // Create a new scene
            let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
            
            if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true)
            {
                diceNode.position = SCNVector3(
                    //                                    world Transform is the 4x4 matrix and the 4th column represent position
                    x: result.worldTransform.columns.3.x,
                    y: result.worldTransform.columns.3.y+diceNode.boundingSphere.radius,       //to make dice is fit perfect on vertical axis
                    z: result.worldTransform.columns.3.z)
                
                diceArray.append(diceNode)
                
                sceneView.scene.rootNode.addChildNode(diceNode)
                
                roll(dice:diceNode)
                
            }
            sceneView.autoenablesDefaultLighting = true
            
            // You can use `result.worldTransform` to place objects
        } else {
            print("Touched somewhere else")
        }
    }
    
    
    func roll(dice:SCNNode){
        //                              Applying animation
        //                              In Y axis the dice does not change the phase so no need to change
        
        let randomX = Float(arc4random_uniform(4)+1) * (Float.pi/2)
        
        let randomZ = Float(arc4random_uniform(4)+1) * (Float.pi/2)
        
        dice.runAction(
            SCNAction.rotateBy(
                x: CGFloat(randomX * 5),
                y: 0,
                z: CGFloat(randomZ * 5),
                duration: 0.5)
        )
    }
    
    
    func rollAll(){
        if !diceArray.isEmpty{
            for dice in diceArray{
                roll(dice:dice)
            }
        }
    }
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
    }
    
//    this method detect when our phone is ended shaking
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
}
