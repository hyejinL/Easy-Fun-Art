//
//  DocentPlayerViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import AVFoundation

protocol PlayerIsOn: class {
    func docentListImageChange(indexPath: Int)
}

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
    @IBOutlet weak var docentPlaceImageView: UIImageView!
    @IBOutlet weak var docentScriptScrollView: UIScrollView!
    
    var audioPlayer =  AVPlayer()
    var music = ["NYC (Frank Sinatra Sample)", "Life In Motion"]
    var audioDuration = 0
    var audioCurrentTime = 0
    var audioCurrentMinute = 0
    var audioCurrentSecond = 0
//    let playerView = DocentPlayerBarView.instanceFromNib()
    var playerItem: CachingPlayerItem?
    var timer:Timer?
    var exhibitionId = -1
    var trackId = -1
    var trackIdList = [Int]()
    var index = -1
    var exhibitionTitle: String?
    var exhibitionImage: String?
    
    var delegate: PlayerIsOn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading(.start)
        
        exhibitionTitleLabel.text = exhibitionTitle
        docentImageView.imageFromUrl(gsno(exhibitionImage), defaultImgPath: "1")
        scriptExhibitionTitleLabel.text = exhibitionTitle
        
        fixSliderThumbSize()
        
        docentFirstSetting()
        docentPlayUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let appdata = UIApplication.shared.delegate as? AppDelegate {
            appdata.playerView.removeFromSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 음악끄기
        audioPlayer.pause()
        audioPlayer.rate = 0
        timer?.invalidate()
        docentFirstSetting()
    }
    
    func docentPlayUpdate() {
        DocentService.shareInstance.docentPlay(exhibitionId: exhibitionId, docentTrack: trackId) { (result) in
            switch result {
            case .success(let docentData):
                self.docentPlaySetting(docentData: docentData)
                self.docentTitleLabel.text = docentData.docent_title
                self.scriptDocentTitleLabel.text = self.docentTitleLabel.text
                self.docentPlaceImageView.imageFromUrl(self.gsno(docentData.docent_place), defaultImgPath: "")
                break
            case .error(let code):
                print(code)
                break
            case .failure(let err):
                self.simpleAlert(title: "네트워크 에러", msg: "인터넷 연결을 확인해주세요.")
                break
            }
        }
    }
    
    func docentPlaySetting(docentData: DocentPlay.DocentPlayData) {
        if let url = URL(string : gsno(docentData.docent_audio)){
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
        
        let stringValue = gsno(docentData.docent_text)
        scriptLabelSpacing(text: stringValue)
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
        
        loading(.start)
        audioPlayer.pause()
        audioPlayer.rate = 0
        docentFirstSetting()
        if index < trackIdList.count-1 {
            index += 1
            trackId = trackIdList[index]
            docentPlayUpdate()
        }
    }
    
    @IBAction func pressedBeforeButton(_ sender: UIButton) {
        sender.buttonAnimation()
        
        loading(.start)
        audioPlayer.pause()
        audioPlayer.rate = 0
        docentFirstSetting()
        if index > 0 {
            index -= 1
            trackId = trackIdList[index]
            docentPlayUpdate()
        }
    }
    
    @IBAction func pressedScriptButton(_ sender: UIButton) {
        sender.buttonAnimation()
        scriptViewShowAndHidden()
    }
    
    @IBAction func pressedLocationButton(_ sender: UIButton) {
        sender.buttonAnimation()
        placeViewShowAndHidden()
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
        
        delegate?.docentListImageChange(indexPath: index)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMusicBar"), object: self, userInfo: ["audio":audioPlayer])
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
//                let docentEndViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentEndViewController.reuseIdentifier) as! DocentEndViewController
//                self.present(docentEndViewController, animated: true, completion: {
//                    self.timer?.invalidate()
//                    self.audioPlayer.pause()
//                    self.audioPlayer.seek(to: CMTime(value: 0, timescale: 1))
//                    self.audioPlayer.rate = 0
//                    self.docentFirstSetting()
                //                })loading(.start)
                self.audioPlayer.pause()
                self.audioPlayer.rate = 0
                self.docentFirstSetting()
                if self.index < self.trackIdList.count-1 {
                    self.index += 1
                    self.trackId = self.trackIdList[self.index]
                    self.docentPlayUpdate()
                }
            })
        }
    }
    
    
    func scriptViewShowAndHidden() {
        if scriptView.isHidden {
            scriptViewShow()
            docentScriptScrollView.isHidden = false
            docentPlaceImageView.isHidden = true
        } else {
            if docentPlaceImageView.isHidden {
                scriptViewHidden(completion: {})
            } else {
                self.docentScriptScrollView.alpha = 0
//                self.scriptExhibitionTitleLabel.alpha = 0
                self.docentScriptScrollView.isHidden = false
//                self.scriptExhibitionTitleLabel.isHidden = false
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.docentPlaceImageView.alpha = 0
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.docentScriptScrollView.alpha = 1
//                        self.scriptExhibitionTitleLabel.alpha = 1
                    }, completion: { _ in
                        self.docentPlaceImageView.isHidden = true
                    })
                })
            }
        }
    }
    
    func placeViewShowAndHidden() {
        if scriptView.isHidden {
            scriptViewShow()
            docentScriptScrollView.isHidden = true
            docentPlaceImageView.isHidden = false
        } else {
            if docentScriptScrollView.isHidden {
                scriptViewHidden(completion: {})
            } else {
                self.docentPlaceImageView.alpha = 0
                self.docentPlaceImageView.isHidden = false
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.docentScriptScrollView.alpha = 0
//                    self.scriptExhibitionTitleLabel.alpha = 0
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.docentPlaceImageView.alpha = 1
                    }, completion: { _ in
                        self.docentScriptScrollView.isHidden = true
//                        self.scriptExhibitionTitleLabel.isHidden = true
                    })
                })
            }
        }
    }
    
    func scriptViewShow() {
        docentScriptScrollView.alpha = 1
        docentPlaceImageView.alpha = 1
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
        self.loading(.end)
        audioDuration = Int(CMTimeGetSeconds(playerItem.asset.duration))
        DispatchQueue.main.async {
            self.audioPlayer.play()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePlaySlider), userInfo: nil, repeats: true)
            self.playButton.isChecked = true
            self.playTimeLabel.text = String(format: "%02d : %02d", self.audioDuration/60, self.audioDuration%60)
        }
    }
}

