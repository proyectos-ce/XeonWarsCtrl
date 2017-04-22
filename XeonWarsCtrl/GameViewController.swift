//
//  ViewController.swift
//  XeonWarsCtrl
//
//  Created by Ignacio Mora on 3/25/17.
//  Copyright © 2017 Ignacio Mora. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
   

   @IBOutlet weak var dataLabel: UILabel!

   @IBAction func receiveData(_ sender: Any) {
      dataLabel.text = myMQTTManager.getDirection()
   }

   
   var myMQTTManager: MQTTManager = MQTTManager()
   
   var myMotionManagement: MotionManagement = MotionManagement()
   
    @IBAction func resetCenter(_ sender: Any) {
      myMotionManagement.updateReference()
    }


   override func viewDidLoad() {
      super.viewDidLoad()
      
      myMQTTManager.connect()
      myMQTTManager.subscribe()
      myMQTTManager.publish(data: "caqueishon".data(using: .utf8)!)
      myMotionManagement.startUpdatingData(mqttManager: myMQTTManager)
      
      
      
   }
   
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

