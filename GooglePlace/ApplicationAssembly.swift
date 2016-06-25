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
    func assemble(container: Container) {
        container.register(ApiKeyManager.self) { r in
            return ApiKeyManager()
        }
    }
}
