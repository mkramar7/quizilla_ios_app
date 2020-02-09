//
//  File.swift
//  Quizilla
//
//  Created by Marko Kramar on 09/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

class GameUtil {
    
    class func playWrongSound() {
        SingletonAudioPlayer.sharedInstance.play("wrong")
    }
    
    class func playCorrectSound() {
        SingletonAudioPlayer.sharedInstance.play("correct")
    }
    
}
