//
//  PodExtensions.swift
//  GooglePlace
//
//  Created by MAX on 8/21/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import Foundation
import SwiftyJSON
import SnapKit

extension JSON {
    init?(filename: String) {
        if let path = NSBundle.mainBundle().pathForResource("NearbySearchResult.json", ofType: "json") {
                guard let data = try? NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: .DataReadingMappedIfSafe) else { return nil }
                    self = JSON(data: data)
        } else {
            return nil
        }
    }
}

//using snap kit
extension UIViewController {
    
    /**
     Add te viewController to be a childViewController and its view to be a subView, create constraint the new childViewController.view to fully cover the original view.
     
     - parameter childController: viewController to be added as a childViewController
     */
    func addChildViewControllerView(childController: UIViewController) {
        
        childController.willMoveToParentViewController(self)
        self.addChildViewController(childController)
        
        addViewToTop(childController.view)
        
        childController.didMoveToParentViewController(self)
        
    }
    
    func addViewToTop(view: UIView) {
        self.view.addSubview(view)
        
        view.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
}