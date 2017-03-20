//
//  Link.swift
//  Flow
//
//  Created by Sacha Durand Saint Omer on 20/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import then

public enum LinkType {
    case push
    case modal
}

public struct Link {
    
    var fromVCClass: UIViewController.Type!
    var toVCClass: UIViewController.Type!
    var config: ((Any) -> (UIViewController))!
    var callbackBlock: (UIViewController) -> Promise<Any>
    var type: LinkType!
    
    public init<T: UIViewController, U: UIViewController, Output>
        (from: T.Type,
         on: @escaping (T) -> Promise<Output>,
         to: @escaping ((Output) -> (U)),
         type: LinkType = .push) {
        self.fromVCClass = from
        self.toVCClass = U.self
        self.config = { any in
            return to(any as! Output)
        }
        self.callbackBlock = { viewController in
            return Promise<Any> { resolve, _ in
                let outputPromise = on(viewController as! T)
                outputPromise.then { output in
                    resolve(output)
                }
            }
        }
        self.type = type
    }
    
    public init<T: UIViewController, U: UIViewController, Output>
        (from: T.Type,
         on: @escaping (T) -> UnsafeMutablePointer<((Output) -> Void)?>,
         to: @escaping ((Output) -> (U)),
         type: LinkType = .push) {
        self.fromVCClass = from
        self.toVCClass = U.self
        self.config = { any in
            return to(any as! Output)
        }
        self.callbackBlock = { viewController in
            return Promise<Any> { resolve, _ in
                let outputCallback = on(viewController as! T)
                outputCallback.pointee = { output in
                    resolve(output)
                }
            }
        }
        self.type = type
    }
    
    public init<T: UIViewController, U: UIViewController, Output>
        (from: T.Type,
         on: @escaping (T) -> UnsafeMutablePointer<((Output) -> Void)?>,
         to: U.Type,
         type: LinkType = .push) {
        self.fromVCClass = from
        self.toVCClass = U.self
        self.config = { _ in
            return to.init()
        }
        self.callbackBlock = { viewController in
            return Promise<Any> { resolve, _ in
                let outputCallback = on(viewController as! T)
                outputCallback.pointee = { output in
                    resolve(output)
                }
            }
        }
        self.type = type
    }
    
    public init<T: UIViewController, U: UIViewController, Output>
        (from: T.Type,
         to: @escaping ((Output) -> (U)),
         type: LinkType = .push) where T:Completable, T.Output == Output {
        self.fromVCClass = from
        self.toVCClass = U.self
        self.config = { any in
            return to(any as! Output)
        }
        self.callbackBlock = { viewController in
            return Promise<Any> { resolve, _ in
                let on = UnsafeMutablePointer(&(viewController as! T).done)
                on.pointee = { out in
                    resolve(out)
                }
            }
        }
        self.type = type
    }
    
    public init<T: UIViewController, U: UIViewController, Output>
        (from: T.Type,
         to: U.Type,
         type: LinkType = .push) where T:Completable, T.Output == Output {
        self.fromVCClass = from
        self.toVCClass = U.self
        self.config = { any in
            return to.init()
        }
        self.callbackBlock = { viewController in
            return Promise<Any> { resolve, _ in
                let on = UnsafeMutablePointer(&(viewController as! T).done)
                on.pointee = { out in
                    resolve(out)
                }
            }
        }
        self.type = type
    }
}
