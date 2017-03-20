//
//  Flow.swift
//  Flow
//
//  Created by Sacha Durand Saint Omer on 20/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import then

open class Flow {
    
    public init() {}
    
    public var initialViewController = UIViewController()
    
    private var links = [Link]()
    
    func register(_ link: Link) {
        links.append(link)
    }
    
    public func register(_ someLinks: Link...) {
        for l in someLinks {
            links.append(l)
        }
    }
    
    func start(inWindow: UIWindow) {
        inWindow.rootViewController = UINavigationController(rootViewController: initialViewController)
        prepare(initialViewController)
    }
    
    public func start(fromVC: UIViewController) {
        prepare(initialViewController)
        fromVC.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    func prepare(_ vc: UIViewController) {
        //find connections
        for link in linksFrom(vc) {
            let promise = link.callbackBlock(vc)
            promise.then { output in
                let nextVC = link.config(output)
                if link.type == .push {
                    vc.navigationController?.pushViewController(nextVC, animated: true)
                } else if link.type == .modal {
                    vc.present(nextVC, animated: true, completion: nil)
                }
                self.prepare(nextVC)
            }
        }
    }
    
    func linksFrom(_ vc: UIViewController) -> [Link] {
        return links.filter { type(of:vc) == $0.fromVCClass }
    }
}

public extension UIWindow {
    
    func start(flow: Flow) {
        flow.start(inWindow: self)
    }
}
