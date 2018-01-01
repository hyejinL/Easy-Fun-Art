//
//  DocentPlayerViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import AVFoundation

class DocentPlayerViewController: UIViewController {
    
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    @IBOutlet weak var docentImageView: UIImageView!
    @IBOutlet weak var docentTitleLabel: UILabel!
    @IBOutlet weak var playButton: ToggleButton!
    @IBOutlet weak var nextPlayButton: UIButton!
    @IBOutlet weak var beforePlayButton: UIButton!
    @IBOutlet weak var playProgressView: UIProgressView!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    
    var audioPlayer =  AVAudioPlayer()
    var music = ["NYC (Frank Sinatra Sample)", "Life In Motion"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "NYC (Frank Sinatra Sample)", ofType: "wav")!))
            audioPlayer.prepareToPlay()
            
            var audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayProgressView), userInfo: nil, repeats: true)
        playProgressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedPlayButton(_ sender: Any) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
    }
    
    @IBAction func pressedNextButton(_ sender: Any) {
        
    }
    
    @IBAction func pressedBeforeButton(_ sender: Any) {
        
    }
    
    @objc func updatePlayProgressView() {
        if audioPlayer.isPlaying {
            playProgressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }

}
