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
    var engine: AVAudioEngine!
    var file: AVAudioFile!
    var audPlay2: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        engine = AVAudioEngine()
        
        do{
            try file = AVAudioFile(forReading: soundFileString)
        } catch {
            print(error)
        }
        
        do {
            try audPlay = AVAudioPlayer(contentsOf: soundFileString!)
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
        
        do {
            try audPlay2 = AVAudioPlayer(contentsOf: soundFileString!)
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view.
        //play the sound
        
            }

    @IBAction func playSlow(_ sender: UIButton) {
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        changeAudioUnitTime.rate = 0.25
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file, at: nil, completionHandler: nil)
        do{
            try engine.start()
        } catch{
            print(error)
        }
        audioPlayerNode.play()
        

    }
    
    @IBAction func playFast(_ sender: UIButton) {
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        changeAudioUnitTime.rate = 3.0
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file, at: nil, completionHandler: nil)
        do{
            try engine.start()
        } catch{
            print(error)
        }
        audioPlayerNode.play()
        

    }
    
    @IBAction func playHigh(_ sender: UIButton) {
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        changeAudioUnitTime.pitch = 1000
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file, at: nil, completionHandler: nil)
        do{
        try engine.start()
        } catch{
            print(error)
        }
        audioPlayerNode.play()
    }
    
    @IBAction func playLow(_ sender: UIButton) {
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        changeAudioUnitTime.pitch = -500
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file, at: nil, completionHandler: nil)
        do{
            try engine.start()
        } catch{
            print(error)
        }
        audioPlayerNode.play()

    }
    
    @IBAction func playEcho(_ sender: UIButton) {
        

        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(.cathedral)
        reverbEffect.wetDryMix = 50
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        engine.attach(reverbEffect)
        engine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        engine.connect(reverbEffect, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file, at: nil, completionHandler: nil)
        do{
            try engine.start()
        } catch{
            print(error)
        }
        audioPlayerNode.play()
        
    }
    
    @IBAction func playNormal(_ sender: UIButton) {
        audPlay!.delegate = self
        audPlay!.prepareToPlay()
        audPlay!.volume = 1.0
        audPlay!.rate = 1
        audPlay!.play()
    }
    
    @IBAction func stopPlaying(_ sender: UIButton) {
        engine.stop()
        audPlay!.stop()
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
