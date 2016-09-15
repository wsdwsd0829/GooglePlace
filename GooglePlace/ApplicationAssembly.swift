//
//  ApplicationAssembly.swift
//  GooglePlace
//
//  Created by MAX on 6/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import UIKit
import Swinject

class ApplicationAssembly: AssemblyType {
    enum ViewController: String {
        case MainTabViewController, ListsViewController, SettingsViewController
        var identifier: String {
            return self.rawValue
        }
        var storyboard: Storyboard {
            switch self {
            case MainTabViewController:
                return .Main
            case ListsViewController:
                return .Lists
            case SettingsViewController:
                return .Settings
            }
        }
    }
    
    enum Storyboard: String {
        case Main, Settings, Lists
        var name: String {
            return self.rawValue
        }
       static var allStoryboards: [Storyboard]{
            return [.Main, .Settings, .Lists]
        }
    }
    
    func assemble(container: Container) {
        registerAllStroyboards(container)
        registerForAppDelegate(container)
        registerAllViewControllers(container)
//        container.register(ApiKeyManager.self) { r in
//            return ApiKeyManager()
//        }
    }
    func registerAllStroyboards(container: Container){
        for storyboard in Storyboard.allStoryboards {
            container.register(UIStoryboard.self, name: storyboard.name) { r in
                return SwinjectStoryboard.create(name: storyboard.name, bundle: nil, container: r)
            }.inObjectScope(.Container)
        }
    }
    func registerAllViewControllers(container: Container){
        //MainTabViewController
        container.registerForStoryboardWithDependencies(MainTabViewController.self)
        
        //Lists
        container.registerForStoryboardWithDependencies(ListsViewController.self) { (r, c) in
           // c.logManager = r.resolve(LogManagerProtocol.self)
            c.googlePlaceService = r.resolve(GooglePlaceServiceType.self)
        }
        
        container.registerForStoryboardWithDependencies(SettingsTableViewController.self){ (r, c) in
             //c.logManager = r.resolve(LogManagerProtocol.self)
        }
        //Settings
    }
    
    func registerForAppDelegate(container: Container) {
        //register for all ViewControllers & Storyboards
        
        //inject window &  root controller & set window's root controller
        container.register(UIWindow.self) { r in
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.makeKeyAndVisible()
           
            return window
        }.inObjectScope(.Container)

    }
    
    /// This is the entry point which set window and rootViewcontroller
    static func resolveAppDelegateDependencies(appDelegate: AppDelegate) {
        //resolve window
        let resolver = appDelegate.assembler.resolver
        appDelegate.window = resolver.resolve(UIWindow.self)
        
        //init a view controller as Window's rootViewController
        let initStoryboard: UIStoryboard = resolver.resolve(UIStoryboard.self, name: Storyboard.Main.name)!
        appDelegate.window!.rootViewController = initStoryboard.instantiateViewControllerWithIdentifier(ViewController.MainTabViewController.identifier)  //or instantialteInitialViewController...
    }

}
extension Container {
    func registerForStoryboardWithDependencies<C: Controller>(controllerType: C.Type, name: String? = nil, initCompleted: ((ResolverType, C) -> ())? = nil ) {
        self.registerForStoryboard(controllerType, name: name){ (r, c) in
            if var dependent = c as? LogManagerDependentProtocol {
                dependent.logManager = r.resolve(LogManagerProtocol.self)!
            }
            
            // Call additional resolver ??
            initCompleted?(r, c)
        }
    }
}