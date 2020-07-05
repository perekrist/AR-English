//
//  SpeechService.swift
//  AR-English
//
//  Created by Кристина Перегудова on 05.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechService {
    private let syntesizer = AVSpeechSynthesizer()
    
    func say(phrase: String, language: String) {
        let uttarance = AVSpeechUtterance(string: phrase)
        uttarance.voice = AVSpeechSynthesisVoice(language: language)
        uttarance.rate = AVSpeechUtteranceDefaultSpeechRate
        
        syntesizer.speak(uttarance)
    }
}
