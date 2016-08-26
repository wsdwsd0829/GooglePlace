//
//  iOS8CompatibleTabReferenceSegue.swift
//  WHH
//
//  Created by Andras Kadar on 28/04/16.
//  Copyright © 2016 Wanda. All rights reserved.
//

import UIKit

/**
 The storyboard references of relationship segue's (like tabbar's viewcontrollers)
 are only supported from iOS 9.0. This is a workaround for this.
 */
class iOS8CompatibleTabReferenceSegue: UIStoryboardSegue {
    
    override func perform() {
        if let sourceTabBarController = self.sourceViewController as? UITabBarController {
            var viewControllers = sourceTabBarController.viewControllers ?? []
            viewControllers.append(self.destinationViewController)
            sourceTabBarController.viewControllers = viewControllers
        }
    }
    
}
