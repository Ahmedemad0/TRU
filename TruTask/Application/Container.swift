//
//  Container.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation
import os

public class Container {
    
    private static var cache: [String: Any] = [:]
    private static var generators: [String: () -> Any] = [:]
    
    public static func register<T>(type: T.Type, as serviceType: ServiceType = .automatic, _ factory: @escaping () -> T) {
        let key = String(describing: type)
        generators[key] = factory
        
        if serviceType == .singleton {
            cache[key] = factory()
        }
    }
    
    public static func resolve<T>(dependencyType: ServiceType = .automatic, _ type: T.Type) -> T? {
        let key = String(describing: type.self)
        switch dependencyType {
        case .singleton:
            if let cachedService = cache[key] as? T {
                return cachedService
            } else {
                fatalError("\(String(describing: dependencyType)) is not registered as singleton")
            }
            
        case .automatic:
            if let cachedService = cache[key] as? T {
                return cachedService
            }
            fallthrough
            
        case .newInstance:
            if let service = generators[key]?() as? T {
                if dependencyType == .automatic {
                    cache[key] = service
                }
                return service
            } else {
                return nil
            }
        }
    }
}

public enum ServiceType: String {
    case singleton
    case newInstance
    case automatic
}


@propertyWrapper
public struct Inject<T> {
    
    var service: T
    
    public init(_ dependencyType: ServiceType = .newInstance) {
        guard let service = Container.resolve(dependencyType: dependencyType, T.self) else {
            fatalError("No dependency of type \(String(describing: T.self)) registered!")
        }
        
        self.service = service
    }
    
    public var wrappedValue: T {
        get { self.service }
        mutating set { service = newValue }
    }
}
