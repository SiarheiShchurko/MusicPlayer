//
//  ViewController.swift
//  Test project for X.One (Siarhei Shchurko)
//
//  Created by Alinser Shchurko on 2.09.22.
//

import UIKit
import AVFoundation
import AVKit
import AVFAudio

class ViewController: UIViewController {
    
    //MARK: Var
    private var rootVM: RootVMProtocol = RootVM()
    private var queuePlayer = AVQueuePlayer()
    private var queuePlayerRevers = AVQueuePlayer()
    private var isSelected: Bool = false
    private var duration: Double = 0.00
    
    //MARK: ImageViewOut
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.isUserInteractionEnabled = true
            imageView.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowOffset = CGSize.zero
            imageView.layer.shadowRadius = 10
            imageView.layer.shouldRasterize = true
            imageView.layer.masksToBounds = false
            imageView.layer.cornerRadius = 10.0 }
    }
    
    //MARK: Labels
    @IBOutlet private weak var passedTime: UILabel!
    @IBOutlet private weak var remainderTime: UILabel!
    @IBOutlet private weak var trackName: UILabel!
    @IBOutlet private weak var groupName: UILabel!
    
    //MARK: Buttons
    @IBOutlet private weak var playStopButton: UIButton!
    @IBOutlet private weak var nextTrackButton: UIButton!
    @IBOutlet private weak var backTrackButton: UIButton!
    
    //MARK: Slider
    @IBOutlet private weak var slider: UISlider!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rootVM.loadTrack()
        initializePlayer()
        swipeTrack()
    }
    
    //MARK: Func for add track to playing queue
    private func addToAllAudioToPlayer() {
        rootVM.audioCollection.forEach({ track in
            let asset = AVURLAsset(url: track.url)
            let item = AVPlayerItem(asset: asset)
            queuePlayer.insert(item, after: queuePlayer.items().last)
            duration = queuePlayer.currentItem?.asset.duration.seconds ?? 0.00
            setForLabels()
        })
    }
    
    //MARK: PlayerInit
    private func initializePlayer() {
        addToAllAudioToPlayer()
    }
    
    //MARK: SwipeToNextFunc
   private func swipeTrack() {
       //RightSwipe
       let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
       rightSwipe.direction = .right
       imageView.addGestureRecognizer(rightSwipe)
       
       //LeftSwipe
       let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
       leftSwipe.direction = .left
       imageView.addGestureRecognizer(leftSwipe)
        }
    
    
    //MARK: Action gesture
    @objc func swipeGesture(sender: UISwipeGestureRecognizer?) {
        if let swipeGest = sender {
            switch swipeGest.direction {
            case .right:
                backTrack()
            case .left:
                nextTrack()
            default:
                break
            }
        }
    }

    
    //MARK: Next track acton (button using)
    @IBAction private func nextTrack() {
        if playStopButton.isSelected {
            if queuePlayer.currentItem == queuePlayer.items().last {
                queuePlayer.advanceToNextItem()
                duration = queuePlayer.currentItem?.asset.duration.seconds ?? 0.00
                initializePlayer()
            } else {
                
                queuePlayer.advanceToNextItem()
                duration = queuePlayer.currentItem?.asset.duration.seconds ?? 0.00 }
        }
    }
    
    //MARK: Back track func (button using)
    @IBAction private func backTrack() {
        if rootVM.reverseAudioCollection.count >= 2 {
            let next = rootVM.reverseAudioCollection[1]
            guard let next = next else { return }
            queuePlayer.removeAllItems()
            queuePlayer.insert(next, after: queuePlayer.currentItem)
            queuePlayer.play()
        }
    }
    
    
    //MARK: Play track
    @IBAction private func playButton() {
        playStopButton.isSelected = !playStopButton.isSelected
        duration = queuePlayer.currentItem?.asset.duration.seconds ?? 0.00
        if queuePlayer.timeControlStatus == .playing {
            queuePlayer.pause()
        } else {
            queuePlayer.play() }
    }
    
    
    //MARK: SetFor labels, ImageViews, slider and time
    
    private func setForLabels() {
        rootVM.audioCollection.forEach { track in
            //Observer
            self.queuePlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1.00, preferredTimescale: 1000), queue: DispatchQueue.main) { [self] time in
                
                //Campare tracks and calculating parametrs
                if self.queuePlayer.currentItem?.asset.duration.seconds == track.duration {
                    self.duration = self.queuePlayer.currentItem?.asset.duration.seconds ?? 0.00
                    
                    //Saved track to used "BackButton"
                    if rootVM.reverseAudioCollection.first != queuePlayer.currentItem {
                        rootVM.reverseAudioCollection.insert(queuePlayer.currentItem, at: 0)
                    }
                    
                    //Set for show track time
                    let minutes = Int(time.seconds) / 60
                    let seconds = Int(time.seconds) % 60
                    let minutesRemainder = Int(self.duration - time.seconds) / 60
                    let secondsRemainder = Int(self.duration - time.seconds) % 60
                    
                    //UI set
                    
                    self.slider.maximumValue = Float(self.duration)
                    self.imageView.image = track.audioImage
                    self.groupName.text = track.artist
                    self.trackName.text = track.trackName
                    self.passedTime.text = String(format: "%02i:%02i", minutes, seconds)
                    self.remainderTime.text = String(format: "-%02i:%02i", minutesRemainder, secondsRemainder)
                    self.slider.value = Float(time.seconds)
                }
            }
            
        }
    }
}






    

    
    
    
   







