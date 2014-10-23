import Foundation

var _currentUser: User?

class User:PFUser {
    
    var userName:String?
    var tagLine: String?
    var profileImg: NSURL?
    var dictionary: NSDictionary
    
     var loginCompletion: ((user:User?, error:NSError?) -> ())?
    
    init (dictionary: NSDictionary) {
        
        self.userName = dictionary ["username"] as? String
        self.tagLine  = dictionary ["tagLine"] as? String
        self.profileImg = dictionary ["profileImg"] as? NSURL
        self.dictionary = dictionary
        
        super.init()
    }
    
//MARK: handel user and logout
    class var currentUser:User? {
        
        get {
            if _currentUser == nil {
                //get from defaults  
                
                //if defaults is not nil, retrieve user state
     
            }
        return _currentUser
        }
        set (user){
            _currentUser = user
            if _currentUser != nil {
                // serilize user information , store in default
                
            } else { //log out here
                //destroy defaults infomation, and current user 
                
            }
        }
    }
    
    
    func loginWithCompletion (userName:String, password:String, completion:(user:User?, error:NSError?) -> () ) {
        loginCompletion = completion
        
        User.logInWithUsernameInBackground(userName, password:password) {(user: PFUser!, error: NSError!) -> Void in
            
            if error == nil {
                if user != nil {
                    //get token 
                    
                    // Do stuff after successful login.
                    
                 }
                
            } else {
                //login error
               self.loginCompletion?(user: nil, error: error)
            }
        }
            
        
    }
    
    func logout(){
        
        User.currentUser  == nil
        //remove token if there any
        
        //notification center for logout notiifcation
        
    }
   

}
 