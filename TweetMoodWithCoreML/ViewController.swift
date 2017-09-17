//
//  ViewController.swift
//  TweetMoodWithCoreML
//
//  Created by Douglas Barreto on 17/09/17.
//  Copyright © 2017 Douglas. All rights reserved.
//

import UIKit
import TwitterKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var client: TWTRAPIClient!
    
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if let session = session {
                print("signed in as \(session.userName)");
                self.client = TWTRAPIClient(userID: session.userID)
                self.featchData()
            } else {
                print("error: \(error!.localizedDescription)");
            }
        })
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func featchData() {
        client.loadTweet(withID: "20") { (tweet, error) in
            if let t = tweet {
                self.tweets = [t]
            } else {
                print("Failed to load Tweet: \(error.debugDescription)")
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TWTRTweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.configure(with: tweet)
        cell.tweetView.backgroundColor = .blue
        cell.tweetView.showBorder = true
        cell.tweetView.showActionButtons = true
        print(tweet.text)
        return cell
    }
}




