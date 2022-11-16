//
//  ResponseManager+SentenceEmbedding.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import NaturalLanguage
import SwiftCSV

extension ResponseManager {
    func calculateScore(with text: String) -> Double {
        if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english) {
            
            let data: CSV<Named> = try! CSV(name: "reason", extension: "csv", bundle: .main)!
            
            var updatedData: [EmbeddingResult] = []
            
            for row in data.rows {
                let reason = row["Reason why sending this money"]
                let suspiciousness = Double(row["Suspiciousness (0-1)"]!)!
                
                let normalizedDistance = 1 / (sentenceEmbedding.distance(between: text, and: reason!))
                
                print(normalizedDistance * suspiciousness)
                
                updatedData.append(EmbeddingResult(reason: reason!,
                                                   normalizedDistance: normalizedDistance,
                                                   suspiciousness: suspiciousness))
            }
            
            let topCandidates = updatedData.sorted {
                $0.normalizedDistance > $1.normalizedDistance
            }[0..<3]
            
            if topCandidates[0].normalizedDistance > 1 {
                return topCandidates[0].suspiciousness
            } else {
                return topCandidates.reduce(0) { partialResult, embedding in
                    partialResult + embedding.normalizedDistance * embedding.suspiciousness
                } / 3
            }
        }
        return 0
    }
}
