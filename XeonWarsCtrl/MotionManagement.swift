//
//  MotionManagement.swift
//  XeonWarsCtrl
//
//  Created by Ignacio Mora on 3/25/17.
//  Copyright © 2017 Ignacio Mora. All rights reserved.
//

import Foundation
import CoreMotion

class MotionManagement{
    
    

    var currentX: Double = 0
    var currentY: Double = 0
    var currentZ: Double = 0
    
    var referenceX: Double = 0
    var referenceY: Double = 0
    var referenceZ: Double = 0
    

    
    let motionManager = CMMotionManager()

    
    func setReference(x: Double, y: Double, z: Double){
        referenceX = x * 100
        referenceY = y * 100
        referenceZ = z * 100
    }
    
    func updateReference(){
        referenceX += self.currentX
        referenceY += self.currentY
        referenceZ += self.currentZ
    }
    
    
    func getDirectionJSON() -> Data{
        let jsonDict = ["x" : floor(currentX/10), "y" : floor(currentY/10) ]
        let toReturn = try! JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
        return toReturn
    }


    
    func startUpdatingData(mqttManager: MQTTManager){
        motionManager.accelerometerUpdateInterval = 0.05

        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            
            self.updateAccData(acceleration: accelerometerData!.acceleration)

            mqttManager.publish(data: self.getDirection())

            if(NSError != nil) {
                print("\(String(describing: NSError))")
            }
        }
    }
    
    func updateAccData(acceleration: CMAcceleration){
        currentX = 100 * acceleration.x - referenceX
        currentY = 100 * acceleration.y - referenceY
        currentZ = 100 * acceleration.z - referenceZ
    }
    
    
    func getDirection() -> Data {
        var result = ""
        if currentX > 20{
            result = "U"
        }
        if currentX < -20{
            result = "D"
        }
        if currentY > 20{
            result = "L"
        }
        if currentY < -20{
            result = "R"
        }
        if (-20 < currentX && currentX < 20) && (-20 < currentY && currentY < 20) {
            result = "C"
        }
        
        return result.data(using: .utf8)!
    }
    
}
