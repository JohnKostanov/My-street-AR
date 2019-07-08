//
//  ViewController.swift
//  My street AR
//
//  Created by  Джон Костанов on 07/07/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//

import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myHouse = createHome()
        myHouse.position = SCNVector3(-2, -2, -5)
        sceneView.scene.rootNode.addChildNode(myHouse)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }

    func createHome() -> SCNNode {
       
        let house = UIImage(named: "art.scnassets/house.jpeg")
        let materialsColor = [house, house, house, house, house, house]
        let materialHouse = materialsColor.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            return material
        }
        
        let box = SCNBox(width: 1, height: 3, length: 10, chamferRadius: 0)
        box.materials = materialHouse
        let buildingHouse = SCNNode(geometry: box)
        

        let roadImage = UIImage(named: "art.scnassets/texture_asphalt.jpg")
        let roadColor = [roadImage]
        let roadMaterial = roadColor.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            return material
        }
        let street = SCNPlane(width: 5, height: 15)
        street.materials = roadMaterial
        let streetNode = SCNNode(geometry: street)
        streetNode.eulerAngles.x = -.pi / 2
        streetNode.position.y = -2.001
        buildingHouse.addChildNode(streetNode)
        
        for z in stride(from: -4, through: 6, by: 2) {
            let tree = createTree()
            tree.position = SCNVector3(2, -1, z)
            buildingHouse.addChildNode(tree)
        }
        return buildingHouse
    }
    
    func createTree() -> SCNNode {
        let stall = SCNCylinder(radius: 0.1, height: 2)
        stall.firstMaterial?.diffuse.contents = UIColor.brown
        let node = SCNNode(geometry: stall)
        
        let crown = SCNSphere(radius: 0.7)
        crown.firstMaterial?.diffuse.contents = UIColor.green
        let crownNode = SCNNode(geometry: crown)
        crownNode.position.y = 1
        node.addChildNode(crownNode)
        node.scale = SCNVector3(0.5, 0.5, 0.5)
        
        return node
    }
}
