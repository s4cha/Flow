//
//  ViewControllers.swift
//  FlowExample
//
//  Created by Sacha Durand Saint Omer on 20/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

struct User {
    var name = "default"
}

class SignUpStep1VC: UIViewController {
    
    var done: ((User) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Step1"
        view.backgroundColor = .white
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.center = view.center
    }
    
    func buttonTapped() {
        let user = User(name: "John doe")
        done?(user)
    }
}

class SignUpStep2VC: UIViewController {
    
    var done: ((User) -> Void)?
    
    convenience init(user: User) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Step2"
        view.backgroundColor = .white
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.center = view.center
    }
    
    func buttonTapped() {
        done?(User())
    }
}

class SignUpStep3VC: UIViewController {
    
    var done: ((User) -> Void)?
    
    convenience init(user: User) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Step3"
        view.backgroundColor = .white
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.center = view.center
    }
    
    func buttonTapped() {
        done?(User())
    }
}

class SignUpStep4VC: UIViewController {
    
    var done: (() -> Void)?
    
    convenience init(user: User) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Step4"
        view.backgroundColor = .white
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.center = view.center
    }
    
    func buttonTapped() {
        done?()
    }
}
