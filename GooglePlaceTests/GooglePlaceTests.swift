//
//  GooglePlaceTests.swift
//  GooglePlaceTests
//
//  Created by MAX on 6/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import XCTest
import SwiftyJSON
import CoreLocation
import PromiseKit
import Swinject
@testable import GooglePlace


class GooglePlaceTests: XCTestCase {
 

    var container: Container!
    override func setUp() {
        super.setUp()
        container = Container() { c in
            c.register(LogManagerProtocol.self) { r in
                return LogManager()
            }.inObjectScope(.Container)
            
            c.register(GooglePlaceServiceType.self) { r in
                 return GooglePlaceTestService()
            }.inObjectScope(.Container)
            
            c.register(ListsViewController.self) { r in
                let controller = ListsViewController()
                //??? this will cause error
               // controller.googlePlaceService = r.resolve(GooglePlaceServiceType.self)
                return controller
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        container = nil
        super.tearDown()
    }
    
    func testFetchNearbyData() {
        
        let googlePlaceTestService = container.resolve(GooglePlaceServiceType.self, name: nil)!
        googlePlaceTestService.fetchPlaces(withSearchText: "xx", forLocation: CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)).then { (data) -> Promise<Void> in
            //print(String(data: data, encoding: NSUTF8StringEncoding))
            
            let json = JSON(data)
            XCTAssertEqual(json["status"], "OK")
            return Promise()
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testViewControllerLoadData() {
        let googleTestService: GooglePlaceServiceType? = container.resolve(GooglePlaceServiceType.self)
        
      
//        let view = listsViewController.view
        guard let controller = container.resolve(ListsViewController.self) else {
            XCTAssertFalse(true, "listsViewController not resolved")
            return }
        //??? follow two line will cause error
//        let aController = ListsViewController()
        //listsViewController.googlePlaceService = GooglePlaceTestService()
//        aController.googlePlaceService = GooglePlaceTestService()
        print(googleTestService)
        
        //controller.viewWillAppear(true)
       // print(controller.jsonDataResults.count)
        //XCTAssertEqual(controller.jsonDataResults.count, 20)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
