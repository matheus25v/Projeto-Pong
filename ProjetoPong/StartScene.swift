//
//  StartScene.swift
//  ProjetoPong
//
//  Created by Matheus Vinicius França on 10/06/2018.
//  Copyright © 2018 Matheus Vinicius França. All rights reserved.
//

import SpriteKit

class StartScene: SKScene{

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        //Menu que configura o botao Inicio
        for touch in touches {
            let location  = touch.location(in: self)
            if atPoint(location).name == "Start" {
                if let scene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    view!.presentScene(scene)
                
            }
        }
    }
    }
    
    
}
