//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var conditionName: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    var dict : [String : Int] = ["Soft":5, "Medium":6, "Hard":7]
    var secondRemaining = 0
    var totalTime = 0
    var progressBar : Float?
    
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelector(_ sender: UIButton) {
        
        timer.invalidate()
        //add exclamation mark here because we might not get a value from the sender title (
        //see it's type by holding option and click on it
        let hardness = sender.currentTitle!
        conditionName.text = hardness
        //if we use dict[hardness] to access our dict value, we will get optional again, because the value that is return by the dict will be an optional because we will not know whether the dict will really have value
        //print(dict[hardness])
        //print(dict[hardness]!)
        secondRemaining = dict[hardness]!
        totalTime = dict[hardness]!
        progressBarView.progress = 1.0
        //everytime we pressed anybutton, we actually change the same button and this will casue our timer become faster and faster
        //hence we need to invalidate the timer everytime before we fire up another timer again
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondRemaining != 0 {
            secondRemaining -= 1
            progressBar = Float(secondRemaining) / Float(totalTime)
            progressBarView.progress = progressBar!
        }
        else{
            timer.invalidate()
            playSound()
            conditionName.text = "Done!"
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}
