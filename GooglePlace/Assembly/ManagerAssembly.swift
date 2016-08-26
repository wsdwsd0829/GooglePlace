//
//  ManagerAssembly.swift
//  GooglePlace
//
//  Created by MAX on 7/31/16.
//  Copyright © 2016 MAX. All rights reserved.
//

import Swinject

class ManagerAssembly: AssemblyType {
    func assemble(container: Container) {
        container.register(LogManagerProtocol.self) { r in
            return LogManager()
        }.inObjectScope(.Container)
        
    }
}
