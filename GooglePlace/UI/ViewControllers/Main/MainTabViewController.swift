//
//  MainTabViewController.swift
//  GooglePlace
//
//  Created by MAX on 7/31/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import UIKit
enum MainTabBarTabs: Int {
    
    case Lists, Settings
    
    private var segueId: String {
        switch self {
        case .Lists: return "toListsTab"
        case .Settings: return "toSettingsTab"
            
        }
    }
    private var imageName: String {
        switch self {
        case .Lists: return "circles"
        case .Settings: return "settings_1"
        }
    }

}
class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("main tab bar controller loaded")
        
        let tabsInOrder: [MainTabBarTabs] = [.Lists, .Settings]
        for tab in tabsInOrder {
            self.performSegueWithIdentifier(tab.segueId, sender: nil)
            if let viewController = self.viewControllers?.last {
                viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: tab.imageName), selectedImage: nil)
            }
        }
        // Do any additional setup after loading the view.
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
