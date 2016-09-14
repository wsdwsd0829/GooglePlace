//
//  ListViewController.swift
//  GooglePlace
//
//  Created by MAX on 7/31/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import UIKit
import MapKit
import PromiseKit
import SwiftyJSON
class ListsViewController: UIViewController, LogManagerDependentProtocol {
    var logManager: LogManagerProtocol!
    var googlePlaceService: GooglePlaceServiceType!
    
    var jsonDataResults: JSON!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        googlePlaceService?.fetchPlaces(withSearchText: "hello", forLocation: CLLocationCoordinate2D(latitude: 37.3382082,longitude: -121.88632860000001)).then { (data) -> Promise<Void> in
            print(String(data: data, encoding: NSUTF8StringEncoding))
            self.jsonDataResults = JSON(data)
            return Promise()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logManager?.logConsole(String(self) + " loaded")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
