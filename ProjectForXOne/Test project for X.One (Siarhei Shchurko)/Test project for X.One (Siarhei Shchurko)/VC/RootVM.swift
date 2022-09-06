//
//  RootVM.swift
//  Test project for X.One (Siarhei Shchurko)
//
//  Created by Alinser Shchurko on 2.09.22.
//

import Foundation
import AVFoundation
import UIKit

protocol RootVMProtocol {
    
    var audioCollection: [Audio] { get set }
    var reverseAudioCollection: [AVPlayerItem?] { get set }
    func loadTrack()
    
}

class RootVM: RootVMProtocol {
    
    //MARK: Start array
    var audioCollection: [Audio] = []
    
    var reverseAudioCollection: [AVPlayerItem?] = []
    
    //MARK: func for load tracks in array
    func loadTrack() {
        audioCollection.append(firstTrack)
        audioCollection.append(secondTrack)
        audioCollection.append(thirdTrack)
        
    }
    
    //MARK: All 3 track object
    let firstTrack = Audio(audioImage: UIImage(named: "FirstTrack") ?? UIImage(), artist: KeysSingers.IsraelKamakawiwoole, trackName: KeysSongs.IsraelKamakawiwoole, url: URL(fileURLWithPath: Bundle.main.path(forResource: KeysSingers.IsraelKamakawiwoole, ofType: "mp3") ?? ""), duration: 212.11428571428573)
    let secondTrack = Audio(audioImage: UIImage(named: "SecondTrack") ?? UIImage(), artist: KeysSingers.TheSlowReadersClub, trackName: KeysSongs.TheSlowReadersClub, url: URL(fileURLWithPath: Bundle.main.path(forResource: KeysSingers.TheSlowReadersClub, ofType: "mp3") ?? "" ), duration: 217.9395918367347)
    let thirdTrack = Audio(audioImage: UIImage(named: "ThirdTrack") ?? UIImage(), artist: KeysSingers.ThirtySecondstoMars, trackName: KeysSongs.ThirtySecondstoMars, url: URL(fileURLWithPath: Bundle.main.path(forResource: KeysSingers.ThirtySecondstoMars, ofType: "mp3") ?? "" ), duration: 372.21877551020407)
    
}


