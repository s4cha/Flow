//
//  Completable.swift
//  Flow
//
//  Created by Sacha Durand Saint Omer on 20/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public protocol Completable: class {
    associatedtype Output
    var done: ((Output) -> Void)? { get set }
}
