//
//  PostTableViewCell.swift
//  MyApp
//
//  Created by 土屋陽香 on 2016/06/22.
//  Copyright © 2016年 Haruka Tsuchiya. All rights reserved.
//

import UIKit
protocol PostTableViewCellDelegate{
    func commentButton_Clicked(post: Post)
}

let jsonDictionary = []

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfilePic: UIImageView!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var likeButton: DesignableButton!

    @IBOutlet weak var commentButton: DesignableButton!
    
    private var currentUserDidLike: Bool = false
    var delegate : PostTableViewCellDelegate!
    
    var post: Post!{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        //画像を丸める
        userProfilePic.layer.cornerRadius = userProfilePic.layer.bounds.width/2
        postImage.layer.cornerRadius = 5.0
        
        userProfilePic.clipsToBounds = true
        postImage.clipsToBounds = true
        
//        userProfilePic.image! = post.user.profileImage
//        userNameLabel.text! = jsonDictionary['nickname'];        createdAt.text! = jsonDictionary['post'];
//        postImage.image! = post.postImage
//        postText.text! = jsonDictionary['created'];
//        likeButton.setTitle("\(post.numberOfLikes) 👍", forState: .Normal)
        
        configureButtonAppearence()
        
    }
    
    private func configureButtonAppearence(){
        likeButton.cornerRadius = 3.0
        likeButton.borderWidth = 2.0
        likeButton.borderColor = UIColor.lightGrayColor()
        likeButton.tintColor = UIColor.lightGrayColor()
        
        commentButton.cornerRadius = 3.0
        commentButton.borderWidth = 2.0
        commentButton.borderColor = UIColor.lightGrayColor()
        commentButton.tintColor = UIColor.lightGrayColor()
    }
    
     internal func changeLikeButtonColor(){
        if currentUserDidLike{
            likeButton.borderColor = UIColor(hex: "b94047")
            likeButton.tintColor = UIColor(hex: "b94047")
        }else{
            likeButton.borderColor = UIColor.lightGrayColor()
            likeButton.tintColor = UIColor.lightGrayColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButton_Clicked(sender: DesignableButton) {
        
        post.userDidLike = !post.userDidLike
        changeLikeButtonColor()
        if post.userDidLike{
            post.numberOfLikes++
        }else{
            post.numberOfLikes--
        }
        
        likeButton.setTitle("\(post.numberOfLikes)👍", forState: .Normal)
        
        currentUserDidLike = post.userDidLike

        
        sender.animation = "pop"
        sender.curve = "spring"
        sender.duration = 1.5
        sender.damping = 0.1
        sender.velocity = 0.2
        sender.animate()
        
        var url = NSURL(string: "http://192.168.33.10/mysns/post/like.php?member_id=9&photo_id=8")
        var request = NSURLRequest(URL:url!)
        var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil))
        
    }
    
    @IBAction func commentButton_Clicked(sender: DesignableButton) {
        sender.animation = "pop"
        sender.curve = "spring"
        sender.duration = 1.5
        sender.damping = 0.1
        sender.velocity = 0.2
        sender.animate()
        delegate?.commentButton_Clicked(post)
    }
    
}
