//
//  GameScene.swift
//  ProjetoPong
//
//  Created by Matheus Vinicius França on 10/06/2018.
//  Copyright © 2018 Matheus Vinicius França. All rights reserved.
//

import SpriteKit

struct BitMask{
    //colisao
    static let Bola: UInt32 = 0x1 << 0
    static let Paddle: UInt32 = 0x1 << 1
}

enum GamePhase {
    //fases do jogo
    case Ready
    case Inplay
    case GameOver
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    //variaveis
    var scoreLabelJogador = SKLabelNode()
    var scoreLabelOponente = SKLabelNode()
    var bola = Bola()
    var jogadorPaddle = Paddle()
    var oponentePaddle = Paddle()
    var phase = GamePhase.Ready
    var JogadorScore = 0
    var OponenteScore = 0
  
    override func didMove(to view: SKView) {
        
        //desenhar o background de primitivas
        let background = CirculoMeio()
        addChild(background)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        
        physicsWorld.contactDelegate = self
        
        //desenhar score
        scoreLabelJogador = childNode(withName: "Score Jogador") as! SKLabelNode
        scoreLabelOponente = childNode(withName: "Score Oponente") as! SKLabelNode
        scoreLabelJogador.text = "Score"
        
        
        //instancia a bola e coloca ela no centro
        addChild(bola)
        bola.position = CGPoint(x: size.width/2, y: size.height/2)
        
        //chama a funcao de iniciar jogo
        startaJogo()
        
        //instancia os 2 jogadores e posiciona
        jogadorPaddle.name = "jogador"
        jogadorPaddle.position = CGPoint(x: size.width/2, y: 200)
        addChild(jogadorPaddle)
        
        oponentePaddle.name = "oponente"
        oponentePaddle.position = CGPoint(x: size.width/2, y: size.height-200)
        oponentePaddle.retangulo.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        addChild(oponentePaddle)
        
        //chama a funcao de reiniciar jogo
        restartaJogo()
        }
    
    
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //configuracao das fases de jogo
        if phase == .Ready {
            phase = .Inplay
            startaJogo()
        }
        
        if phase == .GameOver{
            phase = .Ready
            restartaJogo()
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            //movimentacao dos 2 jogadores
            let location = t.location(in: self)
            jogadorPaddle.position.x = location.x
            oponentePaddle.position.x = location.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        //colisao
        contactInstance(contact, BitMask.Bola, BitMask.Paddle) { (node1,node2) in
            
            let paddle  = node2 as! Paddle
            
            let w = paddle.retangulo.frame.width
            let rightOfPaddle = paddle.position.x + w/2
            let distancia = rightOfPaddle - bola.position.x
            
            //angulo de rebater a bola
            let minAngle = CGFloat.pi*1/6
            let maxAngle = CGFloat.pi*5/6
            let v = linearSpeed((bola.physicsBody?.velocity.dx)!, (bola.physicsBody?.velocity.dy)!)
            
            if paddle.name == "jogador" {
                let angulo = minAngle + (maxAngle - minAngle) * (distancia/w)
                bola.physicsBody?.velocity.dx = v*cos(angulo)
                bola.physicsBody?.velocity.dy = v*sin(angulo)
            }
            
            if paddle.name == "oponente" {
                let angulo = -minAngle + (-maxAngle - (-minAngle)) * (distancia/w)
                bola.physicsBody?.velocity.dx = v*cos(angulo)
                bola.physicsBody?.velocity.dy = v*sin(angulo)
            }
            
            
            //aumento velocidade bola
            bola.physicsBody?.velocity.dx *= 1.1
            bola.physicsBody?.velocity.dy *= 1.1

            
    }
        
        
        
    }
    
    override func didSimulatePhysics() {
        //Ajustando Score
        if phase == .Inplay{
        if bola.position.y<0{
            OponenteScore += 1
            phase = .GameOver
        }
        
        if bola.position.y > size.height{
            JogadorScore += 1
            phase = .GameOver
        }
        
        if bola.position.x  <= 0 || bola.position.x >= size.width {
            bola.physicsBody?.velocity.dx *= -1
            
        }
    }
        
    }
    
    func restartaJogo(){
        
        scoreLabelJogador.text = "\(JogadorScore)"
        scoreLabelOponente.text = "\(OponenteScore)"
        
        bola.position = CGPoint(x: size.width/2, y: size.height/2)
        bola.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        
    }
    
    
    func startaJogo(){
        
        var a = CGFloat()
        if randomCGFloat(0, 1) < 0.5 {
            a = randomCGFloat(CGFloat.pi*1/4, CGFloat.pi*3/4)
            
        } else {
            
             a = randomCGFloat(-CGFloat.pi*1/4, -CGFloat.pi*3/4)
        }
        
        let v: CGFloat = 400
        let dx = v*cos(a)
        let dy = v*sin(a)
        bola.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        
    }
    
    
}
