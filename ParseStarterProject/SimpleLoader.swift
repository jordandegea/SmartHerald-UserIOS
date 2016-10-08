//
//  SimpleLoader.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 07/10/2016.
//  Copyright © 2016 Parse. All rights reserved.
//
import UIKit


class SimpleLoader {
    
    @available(iOS 8.0, *)
    static let alertWindow: UIAlertController = UIAlertController(
        title: "Creating anonymous account",
        message: "Please wait...",
        preferredStyle: UIAlertControllerStyle.Alert);
    
    
    private init(){}
    
    internal static func setDefault(){
        if #available(iOS 8.0, *) {
            SimpleLoader.alertWindow.title = "";
            SimpleLoader.alertWindow.message = "Please wait...";
        } else {
            // Fallback on earlier versions
        };
    }
    
    internal static func set(title:String, message:String){
        if #available(iOS 8.0, *) {
            SimpleLoader.alertWindow.title = title;
            SimpleLoader.alertWindow.message = message;
        } else {
            // Fallback on earlier versions
        };
    }
    
    internal static func presentOn(parent:UIViewController, animated:Bool, completion:  (() -> Void)?){
        if #available(iOS 8.0, *) {
            parent.presentViewController(SimpleLoader.alertWindow, animated: animated, completion: completion)
        } else {
            // Fallback on earlier versions
        }
    }
    
    internal static func dismiss(animated:Bool, completion:  (() -> Void)?){
        if #available(iOS 8.0, *) {
            SimpleLoader.alertWindow.dismissViewControllerAnimated(animated, completion: completion)
        } else {
            // Fallback on earlier versions
        }
    }
    
}