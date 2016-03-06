//
//  HomeViewController.swift
//  Codepath_Instagram
//
//  Created by Lilian Ngweta on 3/5/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var post: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "Post")
        query.whereKey("author", equalTo: PFUser.currentUser()!)
        query.orderByDescending("createdAt")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.post = posts
                self.tableView.reloadData()
                
                print("Success")
                
            } else {
                // handle error
                print("hello?: ")
                print(error)
            }
        }
    }
    
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if  self.post != nil{
            return self.post.count
            
        }else {
            return 0;
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Home", forIndexPath: indexPath) as! HomeTableViewCell
        
        cell.post = post![indexPath.row]
        
        // print("row\(indexPath.row)")
        return cell
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
