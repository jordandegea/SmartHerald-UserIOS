//
//  DownloadCallbackFunction.swift
//  UniversalPush
//
//  Created by Jordan DE GEA on 15/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import Foundation

protocol DownloadCallbackFunction{
    func onDownloadFailed(response:AnyObject , task:DownloadTask );
    func onDownloadCompleteSuccess(response:[String:AnyObject] , task:DownloadTask );
    func onDownloadCompleteFailed(response:AnyObject , task:DownloadTask );
}