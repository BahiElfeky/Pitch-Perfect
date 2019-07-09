//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Bahi El Feky on 1/22/19.
//  Copyright © 2019 Bahi El Feky. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        stopRecordingButton.isEnabled = false
    }
    // MARK: - creating the record file path directory and seesion
    @IBAction func recordButtonAction(_ sender: UIButton) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)[0]
        let recordingName = "recorderVoice.wav"
        let pathArray = [dirPath , recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        configureUI(true)
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecordButton(_ sender: UIButton) {
        configureUI(false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
        // MARK: - toggling labels state
    func configureUI(_ isRecording: Bool = false){
        recordingLabel.text = isRecording ? "Recording in  progress." : "Tap to Record..."
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    }
    //MARK: - Navigate to the next VC
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recorderAudioURL
        }
        else {
            print("recording was not successful!")
        }
    }
    
}


