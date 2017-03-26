//
//  ViewController.swift
//  XeonWarsCtrl
//
//  Created by Ignacio Mora on 3/25/17.
//  Copyright © 2017 Ignacio Mora. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
   
   var currentMaxAccelX: Double = 0.0
   var currentMaxAccelY: Double = 0.0
   var currentMaxAccelZ: Double = 0.0
   

   @IBOutlet var accX: UILabel!
   @IBOutlet var accY: UILabel!
   @IBOutlet var accZ: UILabel!
   @IBOutlet var refAccX: UILabel!
   @IBOutlet var refAccY: UILabel!
   @IBOutlet var refAccZ: UILabel!
   
   @IBOutlet weak var resetButton: UIButton!
   
   let myMotionManagement = MotionManagement()
   
   @IBAction func resetMaxValues(sender: AnyObject) {
      myMotionManagement.updateReference()
      refAccX?.text = "\(myMotionManagement.currentX).2f"
      refAccY?.text = "\(myMotionManagement.currentY).2f"
      refAccZ?.text = "\(myMotionManagement.currentZ).2f"
      
   }
    override func viewDidLoad() {
      super.viewDidLoad()


      currentMaxAccelX = 0
      currentMaxAccelY = 0
      currentMaxAccelZ = 0
      
   
      myMotionManagement.startUpdatingData(viewController: self)
      
      
      
   }
   
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

