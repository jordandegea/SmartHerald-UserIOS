//
//  ServiceTableViewController.swift
//  SharedNews
//
//  Created by Jordan DE GEA on 22/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import CoreData

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

class ServiceTableViewController: LocalStoredPFQueryTableViewController, PFLogInViewControllerDelegate {

    // MARK: Properties
    
    var currentIndexSelected : NSIndexPath!
    
    // MARK : Outlets 

    @IBAction func onLogoutAction(sender: AnyObject) {
        PFUser.logOut()
        showLoginView()
    }
    
    // MARK : Parse Main Query
    
    override func baseQuery() -> PFQuery {
        
        let query = PFQuery(className: "Subscription")
        if ( PFUser.currentUser() == nil ){
            query.whereKeyDoesNotExist("user")
        }else{
            query.whereKey("user", equalTo: PFUser.currentUser()!)
        }
        // Load the service object
        query.includeKey("service")
        //query.orderByAscending(MyOtherKey)
        return query
    }

    // MARK : View Functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
            print("hey sa va")
            print(PARSE_COMPANY)
        #else
            print("coucou salut")
        #endif
        
        if (( PFUser.currentUser()?.isNew ) == nil){
            showLoginView()
        }else{
            self.loadObjects()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataText = (NSBundle.mainBundle().objectForInfoDictionaryKey("PARSE_COMPANY") as! String) + "Please subscribe to a service or a company with the add button"
        
        print("did load")
        print(objects)
        if (( PFUser.currentUser()?.isNew ) == nil){
            showLoginView()
        }else{
            PFUser.currentUser()?.fetchInBackgroundWithBlock({ (object, error) in
                print("reload fecth lo")
                print(object)
                print(error)
                self.loadObjects()
                self.tableView.reloadData()
            })
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cellIdentifier = "ServiceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ServiceTableViewCell
        let service:PFObject = object["service"] as! PFObject ;
        cell.serviceName.text = service["name"] as? String
        
        if ( indexPath.row % 2 == 0 ){
            cell.serviceImage.image = UIImage.fromColor(UIColor(red: 0, green: 0, blue: 1, alpha: 0.04))
        }else{
            // We don't load any color background
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }
    
    
    // MARK : PFUser LogIn Methods */
    
    @objc func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        self.loadObjects()
        self.tableView.reloadData()
        if ( PFUser.currentUser() != nil){
            let installation = PFInstallation.currentInstallation()
            installation.setValue(PFUser.currentUser(), forKey: "user")
            installation.saveInBackground()
            PFCloud.callFunctionInBackground(
                "update_installation",
                withParameters: [
                    "installationId":PFInstallation.currentInstallation().objectId!,
            ])
        }
    }

    
    func showLoginView() {
        let logInViewController = PFLogInViewController()
        logInViewController.delegate = self
        //logInViewController.signUpController.delegate = self
        logInViewController.fields =  [.UsernameAndPassword, .LogInButton, .SignUpButton, .DismissButton, .PasswordForgotten]
        
        self.presentViewController(logInViewController, animated: true, completion: nil)
    }
    
    // MARK : Transitions functions
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if  segue.identifier == "serviceToMessage" {
            let controller = segue.destinationViewController as! SharedMessageTableViewController
            
            //controller.transitioningDelegate = self.animatorController
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell) as NSIndexPath!
            
            self.currentIndexSelected = indexPath
            
            controller.service = self.objectAtIndexPath(indexPath)!["service"] as? PFObject
            //controller.delegate = self
        }
    }

    // MARK : Others
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
