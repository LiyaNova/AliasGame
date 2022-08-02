import Foundation
import AVFoundation

class MusicModel {
    var player: AVAudioPlayer?
    
    func playSound(soundName: String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let path = Bundle.main.path(forResource: soundName, ofType: "wav") else { return }
            let url = URL(fileURLWithPath: path)
            
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
