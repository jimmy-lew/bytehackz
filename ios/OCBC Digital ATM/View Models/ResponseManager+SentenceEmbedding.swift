//
//  ResponseManager+SentenceEmbedding.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import NaturalLanguage

extension ResponseManager {
    func calculateScore(with text: String) -> Double {
        if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english) {
            let sentence = "This is a sentence."
            
            if let vector = sentenceEmbedding.vector(for: sentence) {
                print(vector)
            }
            
            let distance = sentenceEmbedding.distance(between: sentence, and: "That is a sentence.")
            
            print(distance.description)
        }
        
        return 0
    }
}
