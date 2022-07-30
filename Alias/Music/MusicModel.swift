//
//  MusicModel.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 30.07.2022.
//

import Foundation
import AVFoundation


class MusicModel {
    
    var player: AVAudioPlayer?
    
    func playSound(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "wav") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
