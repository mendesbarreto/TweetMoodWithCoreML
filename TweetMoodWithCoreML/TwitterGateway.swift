//
//  TwitterGateway.swift
//  TweetMoodWithCoreML
//
//  Created by Douglas Barreto on 17/09/17.
//  Copyright © 2017 Douglas. All rights reserved.
//

import Foundation
import TwitterKit

final class TwitterGateway {
    private var client: TWTRAPIClient!
    private var tweetIds = ["906947142056595458", //good
                            "909566747048472576", // bad
                            "909465456884486144", //good
                            "908826553722777600", //good
                            "909587244788350976", //bad
                            "909516962652409858", //bad
                            "909581494498349057", //good?
                            "909529961274408964", //bad?
                            "909103800157433856" // ???
                            ]
    
    
    func startTwitterSession(onComplete:(() -> ())? = nil,
                             onError: ((Error?) -> () )? = nil) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if let session = session {
                print("signed in as \(session.userName)");
                self.client = TWTRAPIClient(userID: session.userID)
                onComplete?()
            } else {
                print("error: \(error!.localizedDescription)");
                onError?(error)
            }
        })
    }
    
    func getTweetBy(id: String,
                    onComplete:((TWTRTweet) -> ())? = nil,
                    onError: ((Error?) -> () )? = nil) {
        client.loadTweet(withID: id) { (tweet, error) in
            if let t = tweet {
                onComplete?(t)
            } else {
                print("Failed to load Tweet: \(error.debugDescription)")
                onError?(error)
            }
        }
    }
    
    func getTweets(onComplete:(([TWTRTweet]) -> ())? = nil,
                   onError: ((Error?) -> () )? = nil) {
        client.loadTweets(withIDs: tweetIds) { (tweet, error) in
            if let t = tweet {
                onComplete?(t)
            } else {
                print("Failed to load Tweet: \(error.debugDescription)")
                onError?(error)
            }
        }
    }
    
}

