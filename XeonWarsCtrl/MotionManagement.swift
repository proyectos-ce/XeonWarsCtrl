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
    
   


    
    func startUpdatingData(viewController: ViewController){
        motionManager.accelerometerUpdateInterval = 0.05

        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            
            self.updateAccData(acceleration: accelerometerData!.acceleration)
            viewController.accX?.text = "\(self.currentX).2f"
            viewController.accY?.text = "\(self.currentY).2f"
            viewController.accZ?.text = "\(self.currentZ).2f"
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
    }
    
    func updateAccData(acceleration: CMAcceleration){
        currentX = 100 * acceleration.x - referenceX
        currentY = 100 * acceleration.y - referenceY
        currentZ = 100 * acceleration.z - referenceZ
    }
    
    
    func getDirection() -> String {
        var result = ""
        if currentX > 20{
            result += "u"
        }
        if 
        
        
        return result
    }
    
}
