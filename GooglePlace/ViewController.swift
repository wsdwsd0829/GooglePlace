//
//  ViewController.swift
//  GooglePlace
//
//  Created by MAX on 6/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import UIKit
import PromiseKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let keyDict:[String:String] = ["GooglePlaceApiKey": "AIzaSyAbZruledRtcu4VemFc7NizjONVun0qr-s"]
        
        ApiKeyManager().getKeyForApi(.GooglePlace)
        
        let nearbyUrlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&language=zh-CN&types=food&key=AIzaSyAbZruledRtcu4VemFc7NizjONVun0qr-s"
        
        NSURLSession.GET(nearbyUrlString).then({ (data) -> Void in //Promise<U>
            let dictResult = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            //print(dictResult)
            return
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

