//
//  Commands.swift
//  UniversalPush
//
//  Created by Jordan DE GEA on 15/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import Foundation

/**
 * Created by JordanLeMagnifique on 28/08/2015.
 */
public class APICommand {
    
    static let BASE_ADDRESS: String = "http://127.0.0.1:8001/api/"
    //static let BASE_ADDRESS: String = "http://10.0.2.2:8001/api/"
    static let TYPE_EQUIPMENT:String  = "ANDROID"
    
    func getSubscribeTopicFromService( id:Int ) ->  String{
        return "service_\(id)";
    }
    
    /*
    func set_token(AccountModel accountModel, String token, DownloadCallbackFunction callback){
    DownloadTask downloadTask = new DownloadTask();
    downloadTask._url = BASE_ADDRESS + "equipment/settoken/"+accountModel.getEquipment();
    downloadTask.setRequestMethod("PUT");
    downloadTask.setAuthLogin(accountModel.getLogin());
    downloadTask.setAuthPassword(accountModel.getPassword());
    downloadTask.addRequestProperty("token", token);
    downloadTask._function = callback;
    downloadTask.execute();
    }
    
    func set_type(AccountModel accountModel, DownloadCallbackFunction callback){
    DownloadTask downloadTask = new DownloadTask();
    downloadTask._url = BASE_ADDRESS + "equipment/settype/"+accountModel.getEquipment();
    downloadTask.setRequestMethod("PUT");
    downloadTask.setAuthLogin(accountModel.getLogin());
    downloadTask.setAuthPassword(accountModel.getPassword());
    downloadTask.addRequestProperty("type", TYPE_EQUIPMENT);
    downloadTask._function = callback;
    downloadTask.execute();
    }
    
    func add_equipment(AccountModel accountModel, DownloadCallbackFunction callback){
    DownloadTask downloadTask = new DownloadTask();
    downloadTask._url = BASE_ADDRESS + "account/addequipment";
    downloadTask.setRequestMethod("POST");
    downloadTask.setAuthLogin(accountModel.getLogin());
    downloadTask.setAuthPassword(accountModel.getPassword());
    downloadTask._function = callback;
    downloadTask.execute();
    }*/
    
    static func login(login:String, password:String, callback:DownloadCallbackFunction){
        
        let downloadTask:DownloadTask  = DownloadTask();
        downloadTask._url = BASE_ADDRESS + "account/get";
        downloadTask.setRequestMethod("GET");
        downloadTask.setAuthLogin(login);
        downloadTask.setAuthPassword(password);
        downloadTask._function = callback;
        downloadTask.execute();

    }
    /*
    public final static int message_limit = 10 ;
    
    func get_message_since(AccountModel accountModel, int service_id, int message_id, DownloadCallbackFunction callback){
    DownloadTask downloadTask = new DownloadTask();
    downloadTask._url = BASE_ADDRESS + "messages/getsince/"+service_id+"/"+message_id +"/" + message_limit;
    downloadTask.setRequestMethod("GET");
    downloadTask.setAuthLogin(accountModel.getLogin());
    downloadTask.setAuthPassword(accountModel.getPassword());
    downloadTask._function = callback;
    downloadTask.execute();
    }
    
    func register(String login, String password, DownloadCallbackFunction callback){
    
    DownloadTask downloadTask = new DownloadTask();
    downloadTask._url = BASE_ADDRESS + "account/new";
    downloadTask.setRequestMethod("POST");
    downloadTask.addRequestProperty("login", login);
    downloadTask.addRequestProperty("password", password);
    downloadTask._function = callback;
    downloadTask.execute();
    }
    
    private static DownloadTask SSTask = null ;
    
    func search_service(AccountModel accountModel, String name, DownloadCallbackFunction callback) {
    
    if ( SSTask != null && SSTask.getStatus() == AsyncTask.Status.RUNNING) {
    SSTask.cancel(true);
    }
    
    SSTask = new DownloadTask();
    SSTask._url = BASE_ADDRESS + "service/search/"+name;
    SSTask.setRequestMethod("GET");
    SSTask.setAuthLogin(accountModel.getLogin());
    SSTask.setAuthPassword(accountModel.getPassword());
    SSTask._function = callback;
    SSTask.execute();
    }
    
    /**
    * Requiert POST : service
    * @return
    */
    func subscribe(AccountModel accountModel, int service_id, DownloadCallbackFunction callback) {
    
    DownloadTask downloadTask = new DownloadTask();
    downloadTask.TempData = String.format("%d", service_id);
    downloadTask._url = BASE_ADDRESS + "account/addservice/"+service_id;
    downloadTask.setRequestMethod("POST");
    downloadTask.setAuthLogin(accountModel.getLogin());
    downloadTask.setAuthPassword(accountModel.getPassword());
    downloadTask._function = callback ;
    downloadTask.execute();
    
    }
    
    
    /**
    * Requiert DELETE : service
    * @return
    */
    func unsubscribe(AccountModel accountModel, int service_id, DownloadCallbackFunction callback) {
    
    DownloadTask downloadTask = new DownloadTask();
    downloadTask.TempData = String.format("%d", service_id);
    downloadTask._url = BASE_ADDRESS + "account/deleteservice/"+service_id;
    downloadTask.setRequestMethod("DELETE");
    downloadTask.setAuthLogin(accountModel.getLogin());
    downloadTask.setAuthPassword(accountModel.getPassword());
    downloadTask._function = callback ;
    downloadTask.execute();
    
    }
    /**
    *
    * @param service
    * @return Le nombre du dernier index si connecté à internet
    */
    public static String last_index_token(int service) {
    return BASE_ADDRESS + "service/getlastindexmessage/" + service;
    }
    
    
    /**
    * Requiert POST : service, message
    * @return
    */
    public static String getmessage() {
    return BASE_ADDRESS + "mobile/getmessage/" +
    Configuration.getInstance().getId() + "/" +
    Configuration.getInstance().getLogin() + "/" +
    Configuration.getInstance().getPassword();
    }
*/
}
