//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Grayson Wise on 5/30/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var recording = false
    var stopped = true
    var stringToPass: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        stringToPass = soundFileURL.absoluteString
        print(soundFileURL)
        print(stringToPass)
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordSound(_ sender: UIButton) {
        if audioRecorder?.isRecording == false {
            recording = true
            stopped = false
            print("recording")
            audioRecorder?.record()
        }
        
    }

    @IBAction func stopButton(_ sender: UIButton) {
            audioRecorder?.stop()
            performSegue(withIdentifier: "stopRecording", sender: sender)
        
//            do {
//                try audioPlayer = AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
//                audioPlayer!.delegate = self
//                audioPlayer!.prepareToPlay()
//                audioPlayer!.play()
//            } catch let error as NSError {
//                print("audioPlayer error: \(error.localizedDescription)")
//            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording")
        {
            let newVC: PlaybackViewController = segue.destination as! PlaybackViewController
            newVC.soundFileString = audioRecorder?.url
        }
    }
}

