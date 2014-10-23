import Foundation

class LogInViewController: UIViewController {
    
    @IBOutlet weak var labelUser: UITextField!
    @IBOutlet weak var labelPassword: UITextField!
    var isLogin = false
    
    var registrations = PFObject (className: "Registration")
    var events = PFObject(className: "Event")
    var users = PFObject(className: "User")
    var queryRegistration = PFQuery (className: "Registration")

    
    @IBAction func onTest(sender: AnyObject) {
        var lists = fetchAllRegistration()
        println("\n[\(lists.count)]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
        for each in lists {
            println (each)
        }
    }
    func fetchAllRegistration() -> Array<[String:String]> {
        var lists = Array<[String:String]>()
        var list = [String:String]()
        queryRegistration.findObjectsInBackgroundWithBlock { (registrations: [AnyObject]!, error: NSError!) -> Void in
           // self.registrations = registrations as [PFObject]
            
            var registration:NSDictionary
            
            for registration    in registrations {
                
                println("allKeys \( registration.allKeys)")
                
                var eventid = registration ["niceName"]  as String
                list["eventid"] = eventid
                
                var pfEvent = registration ["event"]?  as PFObject
                var pfUser = registration  ["userRsvped"]? as PFObject
                 pfEvent.fetchIfNeededInBackgroundWithBlock({ (event:PFObject!, error:NSError!) -> Void in
                    list["eventname"] = event["EventName"] as? String
                    list["eventcity"] = event["cityName"] as? String
                     pfUser.fetchIfNeededInBackgroundWithBlock({ (user: PFObject!, error:NSError!) -> Void in
                        list["username"] = user ["username"] as? String
                        list["useremail"] = user["email"] as? String
                        lists.append(list)
                        println("registration is :\(list)")
                     })
                
                })
                
            }
            
        }
    
        return lists

    }
    @IBAction func onSign(sender: AnyObject) {
        loginToParse()
      
    }
    
    func loginToParse(){
        PFUser.logInWithUsernameInBackground(self.labelUser.text, password:self.labelPassword.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if error == nil {
                self.isLogin = true
                println("\n[\( self.isLogin)]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
                println("user login")
            } else {
                println("login error")
                self.isLogin = false
            }
            
            if self.isLogin == true {
                self.performSegueWithIdentifier("toEvents", sender: self)
            } else {
                UIAlertView(title: "login ERROR", message: "login ERROR", delegate: nil, cancelButtonTitle: "OK").show()
                self.labelPassword.text = ""
            }
        }
    }
  
//    func SignUpToParse() {
//        var user = PFUser()
//        user.username = self.labelUser.text
//        user.password = self.labelPassword.text
//        user.email = self.labelEmail.text
//        // other fields can be set just like with PFObject
//        //user["phone"] = "415-392-0202"
//        
//        user.signUpInBackgroundWithBlock {
//            (succeeded: Bool!, error: NSError?) -> Void in
//            if error == nil {
//            println("sign up ok")
//            } else {
//                // let errorString = error.userInfo["error"] as String
//                println("sign up error")
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationController?.CheckedInColor()
        self.title = "CheckedIn"
     }
    
 
}
