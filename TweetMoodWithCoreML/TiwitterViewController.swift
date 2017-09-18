//
//  TiwitterViewController.swift
//  TweetMoodWithCoreML
//
//  Created by Douglas Barreto on 17/09/17.
//  Copyright © 2017 Douglas. All rights reserved.
//

import UIKit
import TwitterKit

class TiwitterViewController: TWTRTimelineViewController {

    convenience init() {
        let client = TWTRAPIClient()
        let dataSource = TWTRSearchTimelineDataSource(searchQuery: "#helloworld", apiClient: client)
        self.init(dataSource: dataSource)
        
        // Show Tweet actions
        self.showTweetActions = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
