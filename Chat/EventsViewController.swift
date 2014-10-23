//
//  EventsViewController.swift
//  Chat
//
//  Created by Cindy Zheng on 10/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class EventsViewController:   UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    var events: [PFObject] = [PFObject]()
    
//        @IBAction func onSend(sender: AnyObject) {
//            var message = PFObject(className: "Message")
//            message["text"] = messageField.text
//            
//            message.saveInBackgroundWithBlock { (result: Bool, error: NSError!) -> Void in
//                self.messageField.text = nil
//                self.fetchMessages()
//            }
//        }

    @IBAction func onLogout(sender: AnyObject) {
    
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Parse"
        //self.navigationController?.CheckedInColor()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.registerNib(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
//        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetchEvents", userInfo: nil, repeats: true)
        fetchEvents()
    }
    
//MARK: parse 

    func fetchEvents() {
        var query = PFQuery(className: "Event")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.events = objects as [PFObject]
            var i:NSDictionary
            for i in self.events {
                println("\(i.allKeys())")
                
                //let objectid = i["objectId"]  as AnyObject?
                //println("\n[\(objectid) ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
            }
            self.tableView.reloadData()
        }
    }
    
//MARK:   tableview datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("table cell count is \(events.count ?? 0)")
        return events.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as EventCell
        var event = events[indexPath.row]
        // cell.imgEvent.image = getEventImageFromParse(indexPath.row)!
        cell.labelCity.text = event["cityName"] as? String
        cell.labelEvent.text = event["EventName"] as? String
        cell.labelTagline.text = event["tagLine"] as? String
        cell.labelZip.text = event["zipCode"] as? String
        
    
//        let userImageFile = event["eventProfileImg"] as PFFile
//        userImageFile.getDataInBackgroundWithBlock {
//            (imageData: NSData!, error: NSError!) -> Void in
//            if error == nil {
//                cell.imgEvent.image = UIImage(data:imageData)
//            }
//        }
        
        
        return cell
    }
    
    func getEventImageFromParse(id:Int) -> UIImage?  {
        let event = events[id]
        var eventImg: UIImage?
        
        let eventPFFImg = event["eventProfileImg"] as PFFile
         eventPFFImg.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                  eventImg = UIImage(data:imageData)
              
            }
        }
        return eventImg ?? nil
     }
        
}
