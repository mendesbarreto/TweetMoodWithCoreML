//
//  StringTokenizer.swift
//  TweetMoodWithCoreML
//
//  Created by Douglas Barreto on 17/09/17.
//  Copyright © 2017 Douglas. All rights reserved.
//

import Foundation

final class StringTokenizer {
    private let string: String
    private let skipStringCount: UInt
    private let options: NSLinguisticTagger.Options
    private let tagger: NSLinguisticTagger
    
    init(string: String,
         options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther],
         skipStringCount: UInt = 3) {
        self.options = options
        self.skipStringCount = skipStringCount
        let schemeLanguage = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
        tagger = NSLinguisticTagger ( tagSchemes: schemeLanguage,
                                      options: Int(self.options.rawValue) )
        self.string = string
    }
    
    func tokenize() -> [String: Double] {
        var wordsCountDic = [String: Double]()
        let nsString = string as NSString
        let range = NSRange(location: 0, length: string.utf16.count)
        tagger.string = string
        tagger.enumerateTags(in: range, scheme: .nameType, options: options) { (_, tokenRange, _, _) in
            let stringToken = nsString.substring(with: tokenRange).lowercased()
            //Here if the token string only will be processed if has the size
            //greater than skipStringCount
            guard stringToken.count > skipStringCount else {
                return
            }
            
            if let wordCount = wordsCountDic[stringToken] {
                wordsCountDic[stringToken] = wordCount + 1.0
            } else {
                wordsCountDic[stringToken] = 1.0
            }
        }
        return wordsCountDic
    }
}
