//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Bahi El Feky on 1/24/19.
//  Copyright © 2019 Bahi El Feky. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    

    @IBOutlet weak var snailButton: UIButton! {
        didSet{
            setButtonImage(button: snailButton)
        }
    }
    @IBOutlet weak var chipmunkButton: UIButton! {
        didSet{
            setButtonImage(button: chipmunkButton)
        }
    }
    @IBOutlet weak var rabbitButton: UIButton! {
        didSet{
            setButtonImage(button: rabbitButton)
        }
    }
    @IBOutlet weak var vaderButton: UIButton! {
        didSet{
            setButtonImage(button: vaderButton)
        }
    }
    @IBOutlet weak var echoButton: UIButton!{
        didSet{
            setButtonImage(button: echoButton)
        }
    }
    @IBOutlet weak var reverbButton: UIButton!{
        didSet{
            setButtonImage(button: reverbButton)
        }
    }
    @IBOutlet weak var stopButton: UIButton!
    // MARK: - Audio Properties
    var recordedAudioURL : URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    // MARK: - playback audio style corrsepondig to button sender tag
    enum ButtonType : Int {
        case slow = 0 ,fast, chimpmunk , vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender : UIButton){
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow: playSound(rate: 0.5)
        case .fast: playSound(rate: 1.5)
        case .chimpmunk: playSound(pitch: 1000)
        case .vader: playSound(pitch: -1000)
        case .echo: playSound(echo: true)
        case .reverb: playSound(reverb: true)

        }
        configureUI(.playing)
    }
    @IBAction func stopButtonPressed(_ sender: AnyObject){
    stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    // MARK: - Pervent button image from stretching
    func setButtonImage(button : UIButton){
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
    }

}
