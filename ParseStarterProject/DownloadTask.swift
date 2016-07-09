//
//  DownloadTask.swift
//  UniversalPush
//
//  Created by Jordan DE GEA on 15/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import Foundation


class DownloadTask {
    
    let TAG:String  = "DownloadTask";
    
    var TempData:String! ;
    var _url:String = "" ;
    var _function:DownloadCallbackFunction! ;
    var map:NSData! ;
    var statusCode:Int! ;
    
    var method:String = "GET";
    var authLogin:String!, authPassword:String! ;
    
    
    func DownloadTask(){
        map = NSData()
    }
    
    func addRequestProperty(field:String , value:String ){
        map.setValue(value, forKey: field)
    }
    
    func setAuthLogin( login:String ){
        authLogin = login;
    }
    
    func setAuthPassword( password:String){
        authPassword = password;
    }
    
    func getStatusCode() -> Int{
        return statusCode;
    }
    
    func setRequestMethod(pmethod:String ){
        method = pmethod;
    }
    /*
    @Override
    protected String doInBackground(String... params) {
    //do your request in here so that you don't interrupt the UI thread
    try {
    return downloadContent();
    } catch (IOException e) {
    return "Unable to retrieve data. URL may be invalid.";
    }
    }
    
    
    @Override
    protected void onPostExecute(String result) {
    if ( _function != null ) {
    _function.onDownloadComplete(result, this);
    }
    }
    */
    
    
    func execute(){
        
        let configuration = NSURLSessionConfiguration .defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        
        let urlString = NSString(format: _url)
        
        print("get wallet balance url string is \(urlString)")
        //let url = NSURL(string: urlString as String)
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: NSString(format: "%@", _url) as String)
        request.HTTPMethod = method
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if ( !authLogin.isEmpty && !authPassword.isEmpty) {
            let authorization:String = authLogin + ":" + authPassword;
            let utf8auth = authorization.dataUsingEncoding(NSUTF8StringEncoding)
            let base64Encoded = utf8auth?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            let authorization64 = "Basic " + base64Encoded!;
            request.addValue(authorization64, forHTTPHeaderField: "Authorization")
        }
        
        /*do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(map, options: [])
        }catch{}*/
        print("coucou")
        let dataTask = session.dataTaskWithRequest(request) {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            
            print("coucou1")
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            
            var isOK = false ;
            
            switch (httpResponse.statusCode)
            {
            case 200: isOK = true ; break ;
            case 201: isOK = true ; break ;
            case 202: isOK = true ; break ;
            case 203: isOK = true ; break ;
            case 204: isOK = true ; break ;
            case 205: isOK = true ; break ;
            case 206: isOK = true ; break ;
            case 207: isOK = true ; break ;
            case 210: isOK = true ; break ;
            default:
                isOK = false ;
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
            
            if ( isOK ){
                
                let response = NSString (data: receivedData, encoding: NSUTF8StringEncoding)
                print("response is \(response)")
                
                print("coucou3")
                if var statusesArray = try? NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments) as? [String: AnyObject]
                {
                    print(statusesArray)
                    let error = statusesArray?.removeValueForKey("error")
                    
                    if ( error != nil ){
                        self._function.onDownloadCompleteFailed(error!, task: self)
                    }else{
                        self._function.onDownloadCompleteSuccess(statusesArray!, task: self)
                    }
                }
            }else{
                //self._function.onDownloadFailed(nil, task: self)
            }
            
        }
        dataTask.resume()
    }
    
}
