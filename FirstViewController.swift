//
//  FirstViewController.swift
//  MyApp
//
//  Created by 土屋陽香 on 2016/06/22.
//  Copyright © 2016年 Haruka Tsuchiya. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var navi: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    var post = Post.allPosts
    var jsonDictionary = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "postCell")
        
        var url = NSURL(string: "http://192.168.33.10/mysns/connect/json.php")
        var request = NSURLRequest(URL:url!)
        var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil))
        jsonDictionary = (try! NSJSONSerialization.JSONObjectWithData(jsondata, options: [])) as! NSArray

       print(jsonDictionary)
//        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        navigationBar.barTintColor = UIColor(hex: "1A237E")
        
        //changeLikeButtonColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

}

extension FirstViewController: UITableViewDataSource, PostTableViewCellDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonDictionary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        //cell.postText.text = jsonDictionary[indexPath.row]
        
        cell.userNameLabel.text! = jsonDictionary[indexPath.row]["nickname"] as! String;
        cell.delegate = self
        return cell
    }
    
}

extension FirstViewController{
    func commentButton_Clicked(post: Post) {
        self.performSegueWithIdentifier("Show Comment Page", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Comment Page"{
            let commentViewController = segue.destinationViewController as! CommentViewController
            commentViewController.post = sender as! Post
        }
    }

}