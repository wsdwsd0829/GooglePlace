//
//  LogManager.swift
//  GooglePlace
//
//  Created by MAX on 7/31/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import Foundation

protocol LogManagerDependentProtocol {
    var logManager: LogManagerProtocol! { get set }
}

protocol LogManagerProtocol {
    
     func logConsole(info: String);
     func logSelfToConsole(obj: AnyObject);
    
}

class LogManager: LogManagerProtocol {
     func logConsole(info: String){
        print(info)
    }
     func logSelfToConsole(obj: AnyObject) {
        print(String(obj) + " loaded")
    }
}