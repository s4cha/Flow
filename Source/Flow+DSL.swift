//
//  Flow+DSL.swift
//  Flow
//
//  Created by Sacha Durand Saint Omer on 20/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import then

precedencegroup LeftAssociativePrecedence {
    associativity: left
}

infix operator -- : LeftAssociativePrecedence

infix operator --> : LeftAssociativePrecedence

public func -- <T: UIViewController, Output>
    (from: T.Type,
     on: @escaping (T) -> Promise<Output>) -> PartialLink<T, Output> {
    var p = PartialLink<T, Output>(fromVCClass: from)
    p.callbackBlock = { viewController in
        return Promise<Output> { resolve, _ in
            let outputPromise = on(viewController as! T)
            outputPromise.then { output in
                resolve(output)
            }
        }
    }
    return p
}

public func --> <T, U: UIViewController, Output>
    (partialLink: PartialLink<T, Output>,
     to: @escaping ((Output) -> (U))) -> Link {
    let l = Link(from: partialLink.fromVCClass, on: { (t:T) -> Promise<Output> in
        return partialLink.callbackBlock(t)
    }, to: to)
    return l
}

public func --> <T: UIViewController, U: UIViewController, Output>
    (from: T.Type,
     to: @escaping ((Output) -> (U))) -> Link where T:Completable, T.Output == Output {
    return Link(from: from, to: to)
}

public struct PartialLink<T:UIViewController, OutPut> {
    
    init(fromVCClass: T.Type) {
        self.fromVCClass = fromVCClass
    }
    var fromVCClass: T.Type!
    var callbackBlock: (UIViewController) -> Promise<OutPut> = { vc in
        return Promise.reject()
    }
}

public func --> <T: UIViewController, U: UIViewController, Output>
    (from: T.Type,
     to: U.Type) -> Link where T:Completable, T.Output == Output {
    return Link(from: from, to: to)
}
