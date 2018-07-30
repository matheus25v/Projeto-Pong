//
//  Background.swift
//  ProjetoPong
//
//  Created by Matheus Vinicius França on 10/06/2018.
//  Copyright © 2018 Matheus Vinicius França. All rights reserved.
//



import SpriteKit

class CirculoMeio: SKNode {
    
    var circulo = SKShapeNode()
    let raio: CGFloat = 150
    
    override init (){
        super.init()
        
        circulo = SKShapeNode(circleOfRadius: raio)
        circulo.lineWidth = 2
        circulo.strokeColor = .white
        addChild(circulo)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -1000, y: 0))
        path.addLine(to: CGPoint(x: 1000, y: 0))
        
        let line = SKShapeNode(path: path)
        line.strokeColor = .white
        line.lineWidth = 1
        addChild(line)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
