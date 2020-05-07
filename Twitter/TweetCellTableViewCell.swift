//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Gulesh Shukla on 4/27/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBAction func reTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetId, success: {
            self.setReTweeted(true)
        }, failure: { (error) in
            print("Error in retweeting\(error)")
        })

    }
    
    var favorited: Bool = false
    var tweetId = -1
    var reTweeted:Bool = false
    
    func setFavourite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage( named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage( named: "favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    func setReTweeted(_ isReTweeted:Bool){
        if(isReTweeted){
            reTweetButton.setImage(UIImage (named: "retweet-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        }
        else{reTweetButton.setImage(UIImage (named: "retweet"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
                
        }
    }
    
    @IBAction func favouriteTweet(_ sender: Any) {
        let tobeFavorited  = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (error) in
                print("Favorite did not succeed\(error)")
            })
        }
        else{
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed\(error)")
            })
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
