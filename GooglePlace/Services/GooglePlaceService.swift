//
//  GooglePlaceService.swift
//  GooglePlace
//
//  Created by MAX on 8/20/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import Foundation
import PromiseKit
import MapKit

enum NetworkError: ErrorType {
    case WrongURL
    case RequestError(NSError)
}

public protocol GooglePlaceServiceType {
    func fetchPlaces(withSearchText searchText: String, forLocation location: CLLocationCoordinate2D) -> Promise<NSData>
}

class GooglePlaceService: GooglePlaceServiceType {
    
    func fetchPlaces(withSearchText searchText: String, forLocation location: CLLocationCoordinate2D) -> Promise<NSData> {
        return Promise { fulfill, reject in
            let requestString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyB0GOYHevVqklOX7KBjsoPW6yjec0ms8dw&location=37.3382082,-121.88632860000001&radius=50000"
            guard let requestURL = NSURL(string: requestString) else {
                reject(NetworkError.WrongURL)
                return
            }
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: sessionConfig)
            let sessionTask = session.dataTaskWithURL(requestURL, completionHandler: { (data, response, error) in
                //handler will be in other thread
                guard error == nil else {
                    reject(NetworkError.RequestError(error!))
                    return
                }
                fulfill(data!)  //this will set back to main thread
            })
       
            sessionTask.resume()
        }
    }
}