//
//  ServiceAssembly.swift
//  GooglePlace
//
//  Created by MAX on 8/20/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import Foundation

import Swinject

class ServiceAssembly: AssemblyType {
    func assemble(container: Container) {
        container.register(GooglePlaceServiceType.self) { r in
            return GooglePlaceService()
            }.inObjectScope(.Container)
        
    }
}
