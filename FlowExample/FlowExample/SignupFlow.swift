//
//  SignupFlow.swift
//  FlowExample
//
//  Created by Sacha Durand Saint Omer on 20/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Flow

class SignupFlow: Flow {
    
    override init() {
        super.init()
        initialViewController = SignUpStep1VC()
        
        register(
            SignUpStep1VC.self --> { SignUpStep2VC(user: $0) },
            SignUpStep2VC.self --> { SignUpStep3VC(user: $0) },
            SignUpStep3VC.self --> { SignUpStep4VC(user: $0) }
        )
        
        // Checkout the registers below for data passing between controllers.
    }
}

extension SignUpStep1VC: Completable {}
extension SignUpStep2VC: Completable {}
extension SignUpStep3VC: Completable {}

// Try copy paste the registers below in the init section.

///* 1 - No data Passing */
//
//// Bare
//register(
//    Link(from: SignUpStep1VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: SignUpStep2VC.self),
//    Link(from: SignUpStep2VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: SignUpStep3VC.self),
//    Link(from: SignUpStep3VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: SignUpStep4VC.self)
//)
//
//// NotYetSupported bare with DSL?
//
//// Comforming to `Completable` (see below)
//register(
//    Link(from: SignUpStep1VC.self, to: SignUpStep2VC.self),
//    Link(from: SignUpStep2VC.self, to: SignUpStep3VC.self),
//    Link(from: SignUpStep3VC.self, to: SignUpStep4VC.self)
//)
//
//// DSL version
//register(
//    SignUpStep1VC.self --> SignUpStep2VC.self,
//    SignUpStep2VC.self --> SignUpStep3VC.self,
//    SignUpStep3VC.self --> SignUpStep4VC.self
//)
//
///* 1 - Data Passing */
//
//// Bare
//register(
//    Link(from: SignUpStep1VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: { SignUpStep2VC(user: $0) }),
//    Link(from: SignUpStep2VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: { SignUpStep3VC(user: $0) }),
//    Link(from: SignUpStep3VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: { SignUpStep4VC(user: $0) })
//)
//
//// NotYetSupported bare with DSL?
//
//// Comforming to `Completable` (see below)
//register(
//    Link(from: SignUpStep1VC.self, to: { SignUpStep2VC(user: $0) }),
//    Link(from: SignUpStep2VC.self, to: { SignUpStep3VC(user: $0) }),
//    Link(from: SignUpStep3VC.self, to: { SignUpStep4VC(user: $0) })
//)

////  DSL
//register(
//    SignUpStep1VC.self --> { SignUpStep2VC(user: $0) },
//    SignUpStep2VC.self --> { SignUpStep3VC(user: $0) },
//    SignUpStep3VC.self --> { SignUpStep4VC(user: $0) }
//)

//        register(
//            SignUpStep1VC.self -- { UnsafeMutablePointer(&$0.done) } --> { SignUpStep2VC(user: $0) }),
////            Link(from: SignUpStep2VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: { SignUpStep3VC(user: $0) }),
////            Link(from: SignUpStep3VC.self, on: { UnsafeMutablePointer(&$0.done) }, to: { SignUpStep4VC(user: $0) })
//        )
