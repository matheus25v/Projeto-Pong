//
//  Bola.swift
//  ProjetoPong
//
//  Created by Matheus Vinicius França on 10/06/2018.
//  Copyright © 2018 Matheus Vinicius França. All rights reserved.
//

import SpriteKit

class Bola: SKNode {
    
    //variaveis
    var circulo = SKShapeNode()
    let raio: CGFloat = 15
    
    override init (){
        super.init()
        
        //configura tamanho e cor
        circulo = SKShapeNode(circleOfRadius: raio)
        circulo.fillColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        addChild(circulo)
    
        //fisica da bola
        physicsBody = SKPhysicsBody(circleOfRadius: raio)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0.5
        physicsBody?.restitution = 1.0
        physicsBody?.categoryBitMask = BitMask.Bola
        physicsBody?.collisionBitMask = BitMask.Paddle
        physicsBody?.contactTestBitMask = BitMask.Paddle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("deu ruim")
    }

}
