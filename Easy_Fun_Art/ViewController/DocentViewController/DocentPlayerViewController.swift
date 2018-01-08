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
    @IBOutlet weak var docentStopButton: UIButton!
    @IBOutlet weak var docentImageView: UIImageView!
    @IBOutlet weak var docentTitleLabel: UILabel!
    @IBOutlet weak var playButton: ToggleButton!
    @IBOutlet weak var nextPlayButton: UIButton!
    @IBOutlet weak var beforePlayButton: UIButton!
    @IBOutlet weak var playSlider: UISlider!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    @IBOutlet weak var scriptView: UIView!
    @IBOutlet weak var scriptExhibitionTitleLabel: UILabel!
    @IBOutlet weak var scriptDocentTitleLabel: UILabel!
    @IBOutlet weak var scriptDocentContentLabel: UILabel!
    
    var audioPlayer =  AVAudioPlayer()
    var music = ["NYC (Frank Sinatra Sample)", "Life In Motion"]
    var audioDuration = 0
    var audioCurrentTime = 0
    var audioCurrentMinute = 0
    var audioCurrentSecond = 0
    var soundData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixSliderThumbSize()

        do {
            do {
                if let url = URL(string : gsno("http://ds54q4yvb82ly.cloudfront.net/Little+Dream.mp3")){
                    soundData = try Data(contentsOf: url)
                }
            } catch let error as Error {
                print(error.localizedDescription)
            }

//            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "NYC (Frank Sinatra Sample)", ofType: "wav")!))
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.prepareToPlay()
            // https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3
            // http://cdn.mos.musicradar.com/audio/samples/80s-heat-demos/AM_Eighties08_85-01.mp3

            let audioSession = AVAudioSession.sharedInstance()

            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: "http://13.124.97.161:3000/")!)
//
//            audioPlayer.play()
//        } catch let error as NSError {
//
//
//
//            print(error.localizedDescription)
//
//        } catch {
//
//            print("AVAudioPlayer init failed")
//
//        }
        
        audioDuration = Int(audioPlayer.duration+1)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlaySlider), userInfo: nil, repeats: true)
//        playTimeLabel.text = "\(Int(audioDuration/60)) : \(audioDuration%60)"
        playTimeLabel.text = String(format: "%02d : %02d", audioDuration/60, audioDuration%60)
        docentFirstSetting()
        
        scriptView.isHidden = true
        scriptView.alpha = 0
        
        let stringValue = "국립현대미술관은 현대영화사에 있어 독보적인 작품세계를 구현한 중요감독들의 작품을 전시로 재구성해 소개하는 프로젝트의 일환으로 <필립 가렐, 찬란한 절망>(2015)에 이어 두 번째 기획으로 미국 독립 실험영화의 대부인 요나스 메카스의 전시 <요나스 메카스 – 찰나, 힐긋, 돌아보다>를 개최한다. 아시아에서 처음으로 개최되는 이번 전시는 미국 아방가르드 영화의 역사를 개척한 리투아니아 출신의 실험영화 감독 요나스 메카스 인생의 중요한 지점, 변화, 흐름을 따라 구성된다. 요나스 메카스는 삶의 매순간을 일기를 쓰듯 자. 국립현대미술관은 현대영화사에 있어 독보적인 작품세계를 구현한 중요감독들의 작품을 전시로 재구성해 소개하는 프로젝트의 일환으로 <필립 가렐, 찬란한 절망>(2015)에 이어 두 번째 기획으로 미국 독립 실험영화의 대부인 요나스 메카스의 전시 <요나스 메카스 – 찰나, 힐긋, 돌아보다>를 개최한다. 아시아에서 처음으로 개최되는 이번 전시는 미국 아방가르드 영화의 역사를 개척한 리투아니아 출신의 실험영화 감독 요나스 메카스 인생의 중요한 지점, 변화, 흐름을 따라 구성된다. 요나스 메카스는 삶의 매순간을 일기를 쓰듯 자."
        scriptLabelSpacing(text: stringValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer.stop()
        docentFirstSetting()
    }
    
    @IBAction func pressedPlayButton(_ sender: UIButton) {
        sender.buttonAnimation()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
    }
    
    @IBAction func pressedNextButton(_ sender: UIButton) {
        sender.buttonAnimation()
    }
    
    @IBAction func pressedBeforeButton(_ sender: UIButton) {
        sender.buttonAnimation()
    }
    
    @IBAction func pressedScriptButton(_ sender: UIButton) {
        sender.buttonAnimation()
        scriptViewShowAndHidden()
    }
    
    @IBAction func pressedLocationButton(_ sender: UIButton) {
        sender.buttonAnimation()
    }
    
    @IBAction func pressedStopDocent(_ sender: Any) {
        audioPlayer.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if sender.isTracking {
            return
        }
        audioPlayer.currentTime = TimeInterval(playSlider.value)*audioPlayer.duration
        updatePlaySlider()
    }
    
    @objc func updatePlaySlider() {
        audioCurrentTime = Int(audioPlayer.currentTime+1)
        audioCurrentMinute = Int(audioCurrentTime/60)
        audioCurrentSecond = audioCurrentTime%60
        
        if audioPlayer.isPlaying {
            playSlider.setValue(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
            currentPlayTimeLabel.text = String(format: "%02d : %02d", audioCurrentMinute, audioCurrentSecond)
            if Float(audioPlayer.currentTime)+1 > Float(audioPlayer.duration) {
                audioPlayer.currentTime = audioPlayer.duration
            }
        }
        if audioCurrentTime == audioDuration {
            scriptViewHidden(completion: {
                let docentEndViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentEndViewController.reuseIdentifier) as! DocentEndViewController
                self.present(docentEndViewController, animated: true, completion: {
                    self.audioPlayer.stop()
                    self.docentFirstSetting()
                })
            })
        }
    }
    
    func scriptViewShowAndHidden() {
        if scriptView.isHidden {
            scriptViewShow()
        } else {
            scriptViewHidden(completion: {})
        }
    }
    
    func scriptViewShow() {
        scriptView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0.3, animations: {
            self.scriptView.alpha = 1
            self.exhibitionTitleLabel.alpha = 0
            self.docentStopButton.alpha = 0
        })
    }
    
    func scriptViewHidden(completion: @escaping ()->Void) {
        if !scriptView.isHidden {
            UIView.animate(withDuration: 0.4, delay: 0.3, animations: {
                self.scriptView.alpha = 0
                self.exhibitionTitleLabel.alpha = 1
                self.docentStopButton.alpha = 1
            }, completion: { _ in
                self.scriptView.isHidden = true
                completion()
            })
        } else {
            completion()
        }
    }
    
    func docentFirstSetting() {
        playSlider.value = 0
        currentPlayTimeLabel.text = "00 : 00"
        playButton.isChecked = false
    }
    
    func fixSliderThumbSize() {
        let thumbImage = #imageLiteral(resourceName: "docent_slider")
        playSlider.setThumbImage(thumbImage, for: .normal)
        playSlider.setThumbImage(thumbImage, for: .highlighted)
    }
    
    func scriptLabelSpacing(text: String) {
        let attrString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 12 // change line spacing between paragraph like 36 or 48
        style.minimumLineHeight = 10 // change line spacing between each line like 30 or 40
        style.alignment = .justified
        
        // Line spacing attribute
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: text.characters.count))
        
        // Character spacing attribute
        attrString.addAttribute(NSAttributedStringKey.kern, value: 2, range: NSMakeRange(0, attrString.length))
        
        scriptDocentContentLabel.attributedText = attrString
    }

}
