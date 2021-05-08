//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var conditionName: UILabel!
    
    var dict : [String : Int] = ["Soft":5, "Medium":6, "Hard":7]
    var secondRemaining = 0
    
    @IBAction func hardnessSelector(_ sender: UIButton) {
        //add exclamation mark here because we might not get a value from the sender title (
        //see it's type by holding option and click on it
        let hardness = sender.currentTitle!
        //if we use dict[hardness] to access our dict value, we will get optional again, because the value that is return by the dict will be an optional because we will not know whether the dict will really have value
        
        //print(dict[hardness])
        //print(dict[hardness]!)
        switch hardness{
        case "Soft":
            secondRemaining = dict[hardness]!
        case "Medium":
            secondRemaining = dict[hardness]!
        case "Hard":
            secondRemaining = dict[hardness]!
        default:
            secondRemaining = 10
        }
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondRemaining != 0 {
            print("\(secondRemaining) seconds.")
            secondRemaining -= 1
        }
        else{
            conditionName.text = "Done!"
        }
    }
    
    
}
