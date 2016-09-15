//
//  NearbyResult.swift
//  GooglePlace
//
//  Created by MAX on 8/21/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import Foundation
import PromiseKit
import CoreLocation
//import SwiftyJSON

enum JSONFileError: ErrorType {
    case PathError
    case ContentError
}

class GooglePlaceTestService: GooglePlaceServiceType {
    func fetchPlaces(withSearchText searchText: String, forLocation location: CLLocationCoordinate2D) -> Promise<NSData> {
        return Promise { fulfill, reject in
            if let path = NSBundle.mainBundle().pathForResource("NearbySearchResult.json", ofType: "json") {
                guard let data = try? NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: .DataReadingMappedIfSafe) else {
                    reject(JSONFileError.ContentError)
                    return
                }
                fulfill(data)
            } else {
                reject(JSONFileError.PathError)
            }
        }
    }
}
