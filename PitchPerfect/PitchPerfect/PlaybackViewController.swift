//
//  SecondViewController.swift
//  PitchPerfect
//
//  Created by Grayson Wise on 5/30/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var soundFileString: URL!
    var audPlay: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //play the sound
        
            }

    @IBAction func playSound(_ sender: UIButton) {
        do {
            print(soundFileString)
            try audPlay = AVAudioPlayer(contentsOf: soundFileString!)
            audPlay!.delegate = self
            audPlay!.prepareToPlay()
            audPlay!.volume = 1.0
            audPlay!.numberOfLoops = 5
            audPlay!.play()
            print("playing")
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
