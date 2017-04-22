//
//  MQTTManager.swift
//  XeonWarsCtrl
//
//  Created by Ignacio Mora on 4/5/17.
//  Copyright © 2017 Ignacio Mora. All rights reserved.
//

import Foundation
import SwiftMQTT

class MQTTManager: MQTTSessionDelegate{
    
    var mqttSession: MQTTSession
    var direction: String

    
    
    init(){
        let myId = "XeonWarsCtrl"
        print("newManager")
        direction = ""
        mqttSession = MQTTSession(host: "192.168.100.11", port: 1883, clientID: myId, cleanSession: true, keepAlive: 15, useSSL: false)
        mqttSession.delegate = self
        
        
    }
    

    
    func connect(){
        mqttSession.connect { (succeeded, error) -> Void in
            if succeeded {
                print("Connected!")
            }
            else{
                print("Error")
            }
        }
    }
    
    func subscribe(){
        mqttSession.subscribe(to: "/XeonDataFrom/PC", delivering: .exactlyOnce) { (succeeded, error) -> Void in
            if succeeded {
                print("Subscribed!")
            }
        }
    }
    
    func publish(data: Data){
        mqttSession.publish(data, in: "/XeonDataFrom/Phone", delivering: .atMostOnce, retain: false) { (succeeded, error) -> Void in
            if succeeded {
                print("Published!")
            }
            else {
                print("error")
            }
        }
    }
    
    func getDirection() -> String{
        print(direction)
        return direction
    }
    


    
    
    func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
        direction = string
        
    }
    
    func mqttDidDisconnect(session: MQTTSession) {
        print(direction)
        
    }
    
    func mqttSocketErrorOccurred(session: MQTTSession) {
        print(direction)
    }
    
    


    
}


