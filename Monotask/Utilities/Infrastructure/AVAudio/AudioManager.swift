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
    case buildUp
    case buildComplete
    case created
    case idled
    case presented
    
    var value: String {
        switch self {
        case .tapped:
            ""
        case .pressed:
            "complete"
        case .switched:
            "switched"
        case .checked:
            "tuing"
        case .unchecked:
            "unchecked"
        case .buildUp:
            "build-up"
        case .buildComplete:
            "build-complete"
        case .created:
            "created"
        case .idled:
            "idle"
        case .presented:
            "presented"
        }
    }
}

class AudioManager {
    static let shared = AudioManager()
    
    var audioPlayerOne: AVAudioPlayer?
    var audioPlayerTwo: AVAudioPlayer?
        
    func playAudioPlayerOne(_ type: SoundEffect, volume: Float = 1, atTime: TimeInterval = 0) {
        guard let url = Bundle.main.url(forResource: type.value, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayerOne = try AVAudioPlayer(contentsOf: url)
            audioPlayerOne?.currentTime = atTime
            audioPlayerOne?.setVolume(volume, fadeDuration: 0.1)
            audioPlayerOne?.prepareToPlay()
            audioPlayerOne?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func playSoundEffectTwo(_ type: SoundEffect, volume: Float = 1, atTime: TimeInterval = 0) {
        guard let url = Bundle.main.url(forResource: type.value, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayerTwo = try AVAudioPlayer(contentsOf: url)
            audioPlayerOne?.currentTime = atTime
            audioPlayerOne?.setVolume(volume, fadeDuration: 0.1)
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
