//
//  UserMood.swift
//  TweetMoodWithCoreML
//
//  Created by Douglas Barreto on 17/09/17.
//  Copyright © 2017 Douglas. All rights reserved.
//

import UIKit

enum UserMood: String {
    case sad = "Neg"
    case good = "Pos"
    case neutral = "Neu"
    
    func asEmoji() -> String {
        switch self {
        case .sad:
            return "😔"
        case .good:
            return "😁"
        case .neutral:
            return "😶"
        }
    }
    
    func asColor() -> UIColor {
        switch self {
        case .sad:
            return .red
        case .good:
            return .green
        case .neutral:
            return .gray
        }
    }
}
