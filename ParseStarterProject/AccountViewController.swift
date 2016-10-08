//
//  AccountViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 05/08/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class AccountViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var tutorial:Bool = false;
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var createAnonymousButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBAction func onCreateAnonymousAction(sender: AnyObject) {
        SimpleLoader.set("Creating anonymous account", message: "Please wait...");
        SimpleLoader.presentOn(self, animated: true, completion: nil)
            
        PFAnonymousUtils.logInWithBlock { (user:PFUser?, error:NSError?) in
            self.loadFields();
            SimpleLoader.dismiss(true, completion: {})
        }
    }
    
    @IBAction func onLogInAction(sender: AnyObject) {
        showLoginView()
    }
    
    @IBAction func onSignUpAction(sender: AnyObject) {
        showSignUpView()
    }
    
    
    @IBAction func onLogOutAction(sender: AnyObject) {
        SimpleLoader.setDefault();
        SimpleLoader.presentOn(self, animated: true, completion: nil)
        
        PFUser.logOut();
        loadFields();
        
        SimpleLoader.dismiss(true, completion: {})
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFields()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (tutorial==true){
            tutorial=false;
            self.performSegueWithIdentifier("accountToTutorial", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadFields(){
        if(PFUser.currentUser() == nil){
            usernameLabel.hidden = true;
            usernameTextField.hidden = true;
            emailLabel.hidden = true;
            emailTextField.hidden = true;
            logOutButton.hidden = true;
            
            createAnonymousButton.hidden = false;
            logInButton.hidden = false;
            signUpButton.hidden = false;
        }else{
            usernameLabel.hidden = !true;
            usernameTextField.hidden = !true;
            emailLabel.hidden = !true;
            emailTextField.hidden = !true;
            logOutButton.hidden = !true;
            
            createAnonymousButton.hidden = !false;
            logInButton.hidden = !false;
            signUpButton.hidden = !false;
            
            let user:PFUser = PFUser.currentUser()!;
            if ( PFAnonymousUtils.isLinkedWithUser(user)){
                usernameTextField.text = "Anonymous"
                //emailTextField.text = ""
            }else{
                usernameTextField.text = PFUser.currentUser()?.username
                emailTextField.text = PFUser.currentUser()?.email
            }
        }

    }
    
    // MARK : PFUser LogIn Methods */
    
    @objc func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        if ( PFUser.currentUser() != nil){
            let installation = PFInstallation.currentInstallation()
            installation.setValue(PFUser.currentUser(), forKey: "user")
            installation.saveInBackground()
            PFCloud.callFunctionInBackground(
                "update_installation",
                withParameters: [
                    "installationId":PFInstallation.currentInstallation().objectId!,
                ])
            loadFields()
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        if ( PFUser.currentUser() != nil){
            let installation = PFInstallation.currentInstallation()
            installation.setValue(PFUser.currentUser(), forKey: "user")
            installation.saveInBackground()
            PFCloud.callFunctionInBackground(
                "update_installation",
                withParameters: [
                    "installationId":PFInstallation.currentInstallation().objectId!,
                ])
            loadFields()
        }
    }
    
    
    func showLoginView() {
        let logInViewController = MyPFLogInViewController()
        logInViewController.delegate = self
        //logInViewController.signUpController.delegate = self
        logInViewController.fields =  [
            .UsernameAndPassword,
            .LogInButton,
            .DismissButton,
            .PasswordForgotten]
        
        self.presentViewController(logInViewController, animated: true, completion: nil)
    }
    func showSignUpView() {
        let signUpViewController = MyPFSignUpViewController()
        signUpViewController.delegate = self
        signUpViewController.fields =  [
            .UsernameAndPassword,
            .SignUpButton,
            .DismissButton]
        
        self.presentViewController(signUpViewController, animated: true, completion: nil)
    }

}
