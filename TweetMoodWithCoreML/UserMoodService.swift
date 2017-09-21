//
//  UserMoodService.swift
//  TweetMoodWithCoreML
//
//  Created by Douglas Barreto on 17/09/17.
//  Copyright © 2017 Douglas. All rights reserved.
//

import UIKit
import CoreML

final class UserMoodService {
    private let model = SentimentPolarity()
    
    func predictWith(string: String) -> SentimentPolarityOutput {
        let wordsCountDic = StringTokenizer(string: string).tokenize()
        var prediction: SentimentPolarityOutput!
        
        let model = SentimentPolarity()
        
        do {
            prediction = try model.prediction(input: wordsCountDic)
        } catch let error {
            print("Problem to predict the input data: \(error.localizedDescription)")
        }
        
        return prediction
    }
    
    func predictMoodWith(string: String) -> UserMood {
        let output = predictWith(string: string)
        return UserMood(rawValue: output.classLabel) ?? .neutral
    }
    
    func predictMoodColorWith(string: String) -> UIColor {
        let output = predictWith(string: string)
        let classLabel = output.classLabel
        let greenValue = (output.classProbability[UserMood.good.rawValue]!)
        let redValue = (output.classProbability[UserMood.sad.rawValue]!)
        
        let userMood = UserMood(rawValue: classLabel)!
        print(greenValue)
        print(redValue)
        switch userMood {
        case .good:
             return UIColor(red: CGFloat(redValue), green: CGFloat(greenValue), blue: 0, alpha: 1)
        case .sad:
            return UIColor(red: CGFloat(redValue), green: CGFloat(greenValue), blue: 0, alpha: 1)
        case .neutral:
            return .gray
        }
    }
}
