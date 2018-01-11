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
    
    var audioPlayer =  AVPlayer()
    var music = ["NYC (Frank Sinatra Sample)", "Life In Motion"]
    var audioDuration = 0
    var audioCurrentTime = 0
    var audioCurrentMinute = 0
    var audioCurrentSecond = 0
    let playerView = DocentPlayerBarView.instanceFromNib()
    var playerItem: CachingPlayerItem?
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixSliderThumbSize()
        
        if let url = URL(string : gsno("http://ds54q4yvb82ly.cloudfront.net/Little+Dream.mp3")){
            playerItem = CachingPlayerItem(url: url)
            playerItem?.delegate = self
            playerItem?.download()
            audioPlayer = AVPlayer(playerItem: playerItem)
            audioPlayer.automaticallyWaitsToMinimizeStalling = false
        }
        
        self.docentFirstSetting()
        
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePlaySlider), userInfo: nil, repeats: true)
        
        do {
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
                
                try audioSession.setActive(true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        scriptView.isHidden = true
        scriptView.alpha = 0
        
        let stringValue = "국립현대미술관은 현대영화사에 있어 독보적인 작품세계를 구현한 중요감독들의 작품을 전시로 재구성해 소개하는 프로젝트의 일환으로 <필립 가렐, 찬란한 절망>(2015)에 이어 두 번째 기획으로 미국 독립 실험영화의 대부인 요나스 메카스의 전시 <요나스 메카스 – 찰나, 힐긋, 돌아보다>를 개최한다. 아시아에서 처음으로 개최되는 이번 전시는 미국 아방가르드 영화의 역사를 개척한 리투아니아 출신의 실험영화 감독 요나스 메카스 인생의 중요한 지점, 변화, 흐름을 따라 구성된다. 요나스 메카스는 삶의 매순간을 일기를 쓰듯 자. 국립현대미술관은 현대영화사에 있어 독보적인 작품세계를 구현한 중요감독들의 작품을 전시로 재구성해 소개하는 프로젝트의 일환으로 <필립 가렐, 찬란한 절망>(2015)에 이어 두 번째 기획으로 미국 독립 실험영화의 대부인 요나스 메카스의 전시 <요나스 메카스 – 찰나, 힐긋, 돌아보다>를 개최한다. 아시아에서 처음으로 개최되는 이번 전시는 미국 아방가르드 영화의 역사를 개척한 리투아니아 출신의 실험영화 감독 요나스 메카스 인생의 중요한 지점, 변화, 흐름을 따라 구성된다. 요나스 메카스는 삶의 매순간을 일기를 쓰듯 자."
        scriptLabelSpacing(text: stringValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 음악끄기
        audioPlayer.pause()
        audioPlayer.rate = 0
        timer?.invalidate()
        docentFirstSetting()
    }
    
    @IBAction func pressedPlayButton(_ sender: UIButton) {
        sender.buttonAnimation()
        if audioPlayer.rate == 0 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePlaySlider), userInfo: nil, repeats: true)
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
        audioPlayer.pause()
        audioPlayer.rate = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if sender.isTracking {
            return
        }
        
        let seconds = Int64(playSlider.value*Float(CMTimeGetSeconds((playerItem?.duration)!)))
        let targetTime: CMTime = CMTimeMake(seconds, 1)
        print(targetTime)
        audioCurrentTime = Int(CMTimeGetSeconds(targetTime))
        print(audioCurrentTime)
        audioPlayer.seek(to: targetTime)
        
        updatePlaySlider()
    }
    
    @IBAction func openMusicBar(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        playerView.frame = CGRect(x: 0, y: (667-99)*self.view.frame.height/667, width: self.view.frame.width, height: 50*self.view.frame.height/667)
        playerView.configure()
        
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(playerView)
        
    }
    
    @objc func updatePlaySlider() {
        audioCurrentTime = Int(CMTimeGetSeconds(audioPlayer.currentTime()))
        audioCurrentMinute = Int(audioCurrentTime/60)
        audioCurrentSecond = audioCurrentTime%60
        
        print(CMTimeGetSeconds(playerItem!.duration))
        if audioPlayer.rate != 0 {
            playSlider.setValue(Float(Float64(audioCurrentTime) / CMTimeGetSeconds(playerItem!.duration)), animated: true)
            currentPlayTimeLabel.text = String(format: "%02d : %02d", audioCurrentMinute, audioCurrentSecond)
        }
        if audioCurrentTime == audioDuration && audioDuration != 0 {
            scriptViewHidden(completion: {
                let docentEndViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentEndViewController.reuseIdentifier) as! DocentEndViewController
                self.present(docentEndViewController, animated: true, completion: {
                    self.timer?.invalidate()
                    self.audioPlayer.pause()
                    self.audioPlayer.seek(to: CMTime(value: 0, timescale: 1))
                    self.audioPlayer.rate = 0
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


extension DocentPlayerViewController: CachingPlayerItemDelegate{
    
    // 다운로드 완료
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("다운 완료")
        
    }
    
    // 시작 가능
    func playerItemReadyToPlay(_ playerItem: CachingPlayerItem) {
        print("시작가능")
        audioDuration = Int(CMTimeGetSeconds(playerItem.asset.duration))
        DispatchQueue.main.async {
            self.playTimeLabel.text = String(format: "%02d : %02d", self.audioDuration/60, self.audioDuration%60)
        }
    }
}

