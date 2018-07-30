//
//  Paddle.swift
//  ProjetoPong
//
//  Created by Matheus Vinicius França on 10/06/2018.
//  Copyright © 2018 Matheus Vinicius França. All rights reserved.
//

import Foundation
import SpriteKit

class Paddle: SKNode{
    //variaveis
    var retangulo = SKShapeNode()
    
    override init() {
        super.init()
        
        //seta tamanho e cor
        retangulo = SKShapeNode(rectOf: CGSize(width: 200, height: 40))
        retangulo.fillColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        retangulo.lineWidth = 0
        addChild(retangulo)
        
        
        //fisica dos jogadores
        physicsBody = SKPhysicsBody(rectangleOf: retangulo.frame.size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0
        physicsBody?.restitution = 0
        physicsBody?.categoryBitMask = BitMask.Paddle
        physicsBody?.collisionBitMask = BitMask.Bola
        physicsBody?.contactTestBitMask = BitMask.Bola
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("deu ruim")
    }
    

}
