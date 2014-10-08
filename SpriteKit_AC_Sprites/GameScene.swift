//
//  GameScene.swift
//  SpriteKit_AC_Sprites
//
//  Created by Julio César Fernández Muñoz on 5/10/14.
//  Copyright (c) 2014 AppleCoding. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var naveTocada:String = ""
    var tocoNave:Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Configura aquí tu escena */
        
        let nave1 = SKSpriteNode(imageNamed: "Spaceship")
        let nave2 = SKSpriteNode(imageNamed: "Spaceship")
        // Creamos dos constantes con dos naves: nave1 y nave2
        
        nave1.position = CGPoint(x: 400, y: 200)
        nave2.position = CGPoint(x: 400, y: 400)
        // Cambios su propiedad "position" para colocarlas en 200,200 y 400,400
        
        nave1.zPosition = 2
        nave2.zPosition = 1
        
        nave1.xScale = 0.5
        nave1.yScale = 0.5
        nave2.xScale = 0.4
        nave2.yScale = 0.4

        nave1.name = "nave1"
        nave2.name = "nave2"
        
        self.addChild(nave1)
        self.addChild(nave2)
        // Las colocamos en pantalla añadiendo a la escena con addChild
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Se lanza cuando se inicia un toque */

        let touch = touches.anyObject() as UITouch
        // Recuperamos la posición que se ha tocado

        if (!tocoNave) {
            let location = touch.locationInNode(self)
            let spriteTocado = self.nodeAtPoint(location)
            // Recuperamos el nodo que haya en el punto tocado
            if (spriteTocado.name != nil && (spriteTocado is SKSpriteNode)) {
                tocoNave = true
                // Encendemos el semáforo
                naveTocada = spriteTocado.name!
                // Guardamos el valor del nombre de la nave tocada
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if (tocoNave) {
            let touch = touches.anyObject() as UITouch
            let position = touch.locationInNode(self)
            // Posición tocada
            
            let previousPosition = touch.previousLocationInNode(self)
            // Posición previa
            
            let moveTo = CGPoint (x: position.x - previousPosition.x, y: position.y - previousPosition.y)
            // Restamos los valores x e y de ambas posiciones para obtener la diferencia entre ambas posiciones
            
            let spriteTocado = self.childNodeWithName(naveTocada) as SKSpriteNode
            // Recuperamos nuestra nave a través de su nombre
            
            spriteTocado.position = CGPoint(x: spriteTocado.position.x + moveTo.x, y: spriteTocado.position.y + moveTo.y)
            // Cambiamos la posición sumando la diferencia de las posiciones actuales y anterior a la posición actual de la nave
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if (tocoNave) {
            tocoNave = false
            naveTocada = ""
            // Fuera semáforo
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        if (tocoNave) {
            tocoNave = false
            naveTocada = ""
            // Fuera semáforo
        }
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Se llama antes de renderizar cada frame */
    }
}
