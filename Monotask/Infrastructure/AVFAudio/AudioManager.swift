//
//  AudioManager.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 19/08/24.
//

import Foundation
import AVFAudio

public enum SoundEffect {
    case tapped
    case pressed
    case switched
    case checked
    case unchecked
    case unlocked
    case locked
    case buildUp
    case buildComplete
    
    var value: String {
        switch self {
        case .tapped:
            ""
        case .pressed:
            "complete"
        case .switched:
            ""
        case .checked:
            "tuing"
        case .unchecked:
            ""
        case .unlocked:
            ""
        case .locked:
            ""
        case .buildUp:
            "build-up"
        case .buildComplete:
            "build-complete"
        }
    }
}

class AudioManager {
    static let shared = AudioManager()
    
    var audioPlayerOne: AVAudioPlayer?
    var audioPlayerTwo: AVAudioPlayer?
        
    func playAudioPlayerOne(_ type: SoundEffect, atTime: TimeInterval = 0) {
        guard let url = Bundle.main.url(forResource: type.value, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayerOne = try AVAudioPlayer(contentsOf: url)
            audioPlayerOne?.currentTime = atTime
            audioPlayerOne?.prepareToPlay()
            audioPlayerOne?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func playSoundEffectTwo(_ type: SoundEffect) {
        guard let url = Bundle.main.url(forResource: type.value, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayerTwo = try AVAudioPlayer(contentsOf: url)
            audioPlayerTwo?.prepareToPlay()
            audioPlayerTwo?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayerOne?.setVolume(0.1, fadeDuration: 1)
        audioPlayerOne?.stop()
    }
}
