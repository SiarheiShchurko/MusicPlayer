//
//  Audio.swift
//  Test project for X.One (Siarhei Shchurko)
//
//  Created by Alinser Shchurko on 2.09.22.
//

import Foundation
import UIKit
import AVFoundation

var viewC: ViewController?
//MARK: Enum for keys singers name
enum KeysSingers {

    static let IsraelKamakawiwoole = "Israel_Kamakawiwoole"
    static let TheSlowReadersClub = "The_Slow_Readers_Club"
    static let ThirtySecondstoMars = "Thirty_Seconds_to_Mars"
    
}

//MARK: Enum for keys song names
enum KeysSongs {
    
    static let IsraelKamakawiwoole = "Over The Rainbow"
    static let TheSlowReadersClub = "Forever in Your Debt"
    static let ThirtySecondstoMars = "Hurricane"
    
}

//MARK: Audio struct. All data which needs about track
struct Audio {
    var audioImage: UIImage
    var artist: String
    var trackName: String
    var url: URL
    var duration: Double 
    }



