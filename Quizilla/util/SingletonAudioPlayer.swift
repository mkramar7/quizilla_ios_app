//
//  SingletonAudioPlayer.swift
//  Quizilla
//
//  Created by Marko Kramar on 09/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//
import AVFoundation

class SingletonAudioPlayer {
    static let sharedInstance = SingletonAudioPlayer()
    private var player: AVAudioPlayer?
    
    func initialize() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    func play(_ sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            DispatchQueue.global().async {
                player.play()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func stop() {
        player?.stop()
    }
}
