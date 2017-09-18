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
    
    let twitterGateway = TwitterGateway()
    let userMoodService = UserMoodService()
    
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
        twitterGateway.startTwitterSession(onComplete: {
            self.fetchData()
        })
    }
    
    private func fetchData() {
        twitterGateway.getTweets(onComplete: { (tweets) in
            self.tweets = tweets
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TWTRTweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.configure(with: tweet)
        cell.tweetView.showBorder = true
        cell.tweetView.showActionButtons = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tweetCell = cell as! TWTRTweetTableViewCell
        let tweet = tweets[indexPath.row]
        let cellBackgroundCollor = userMoodService.predictMoodWith(string: tweet.text).asColor()
        tweetCell.tweetView.backgroundColor = cellBackgroundCollor
    }
    
    
}




